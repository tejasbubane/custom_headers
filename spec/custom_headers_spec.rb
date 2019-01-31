require "yaml"

describe Rack::CustomHeaders do
  let(:app) { lambda { |env| [200, {}, [env.to_yaml]] } }
  let(:header_options) do
    {
      "X-Trace-ID" => -> { "abcd" },
      "X-Request-ID" => -> { "1234".to_i }
    }
  end
  let(:stack) do
    Rack::CustomHeaders.new app, header_options
  end
  let(:request) { Rack::MockRequest.new stack }

  context "when headers don't exist" do
    it "generates given headers" do
      headers = request.get("/").headers
      expect(headers["X-Trace-ID"]).to eq("abcd")
      expect(headers["X-Request-ID"]).to eq(1234)
    end
  end

  # Headers might be already present in the request/response
  context "when headers exist" do
    it "does not override them" do
      response = request.get "/", "X-Trace-ID" => "already-present-here"
      expect(response.headers["X-Trace-ID"]).to eq("already-present-here")
    end
  end

  context "when generator is given as default" do
    let(:header_options) do
      { "X-Trace-ID" => :default }
    end

    it "generates a UUID for the header" do
      headers = request.get("/").headers
      uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

      expect(headers["X-Trace-ID"]).to match(uuid_regex)
    end

    it "generates different UUIDs" do
      first_uuid = request.get("/").headers["X-Trace-ID"]
      second_uuid = request.get("/").headers["X-Trace-ID"]

      expect(first_uuid).not_to eq(second_uuid)
    end
  end
end
