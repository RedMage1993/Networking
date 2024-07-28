A networking library that lets you build requests, choose between FormURL and JSON encoding, and execute requests.

```
public class DefaultGraphQLClient: GraphQLClient {
    public let networking: Networking

    public init(networking: Networking) {
        self.networking = networking
    }

    public func request<Input: Codable, Output: Codable>(query: String, input: Input) async throws -> Output {
        let query = GraphQLRequest(
            query: query,
            variables: GraphQLInput(input: input)
        )

        let request = try await networking.requestBuilder.buildRequest(
            endpoint: "/graphql",
            method: .post,
            headers: nil,
            parameters: nil,
            body: query,
            encoder: JSONRequestBodyEncoder()
        )

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601WithTimeZone

        let graphQLResponse: GraphQLResponse<Output> = try await networking.networkTransport.executeRequest(request, jsonDecoder: jsonDecoder)

        return graphQLResponse.data
    }
}
```