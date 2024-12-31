# Learning Web Development in Ruby

### Content

1. **Ruby**
   - **Mise**: An environment manager to handle multiple programming languages and their versions.
   - **Bundler**: A dependency manager for Ruby projects to ensure consistent gem versions.
   - **Gem**: Ruby libraries packaged for distribution; managed with the `gem` command.

   - **Class**: Defines the blueprint for objects.
     - **Inheritance**: Enables classes to inherit behavior from parent classes. e.g., `ruby/vihicle.rb`
     - **Constructor**: The `initialize` method, called automatically when creating an object. e.g., `ruby/person.rb`
     - **Getter and Setter**: Methods to access or modify object attributes; can use `attr_accessor`. e.g., `ruby/book.rb`
     - **Singleton**: Ensures a class has only one instance. e.g., `singlerb`
     - **Super()**: Calls the method of the same name from the parent class. e.g., `ruby/shape.rb`
     - **Self**: Refers to the current instance or class context. e.g., `ruby/self.rb`

   - **Object**: An instance of a class, encapsulating data and methods.

   - **Method**: Reusable code blocks defined with `def`.
     - **Bang Method**: Ends with `!`, indicating it modifies the caller. Used for raising errors. e.g., `ruby/b.rb`
     - **Predicate Method**: Ends with `?`, returning a boolean.
     - **Undef**: Removes a method from a class or module.
     - **Alias**: Creates a new name for an existing method.
     - **Missing Method**: Handles undefined methods dynamically using `method_missing`.

   - **Variable** (`a`, `@a`, `@@a`, `$a`, `A`):
     - **Local Variable**: Scoped within a block or method.
     - **Instance Variable**: Scoped to an object instance.
     - **Class Variable**: Shared across a class and its instances.
     - **Global Variable**: Available everywhere.
     - **Constant**: Immutable variables with global scope.
       e.g., `ruby/Car.rb`

   - **Module**: A collection of methods and constants, used for mixins and namespaces. e.g., `ruby/greet.rb`

     - **Include**: Mixes module methods into a class.
     - **Prepend**: Adds module methods before existing methods.
     - **Require**: Loads external libraries or Ruby files.

   - **Access Control**:
     - **Public**: Accessible from anywhere.
     - **Private**: Accessible only within the defining class.
     - **Protected**: Accessible by instances of the same class or subclasses.
       e.g., `ruby/ac.rb`

   - **Hash**:
     - **Symbol vs String in Hash**: Symbols are immutable and memory-efficient for keys, while strings are mutable. Access accordingly to how you define them.

   - **Block**: Anonymous code passed to a method. e.g., `ruby/block.rb`
   - **Lambda**: A stricter anonymous function.
   - **Proc**: Similar to a lambda but less strict with arguments.

   - **Iterators**:
     - `downto` / `upto`: For decrementing/incrementing in loops. e.g., `5.downto(1)`
     - **Conditionals**:
       - `if` / `unless`: Conditional expressions.
       - `while` / `until`: Looping constructs.
     - `$LOAD_PATH << "."`: Adds a directory to Ruby's library search path.

   - **Control Flow**:
     - `next`: Skip to the next iteration.
     - `break`: Exit the loop.
     - `redo`: Restart the current iteration.
     - `retry`: Retry the entire loop (deprecated).
     - `raise`: Raise an exception.

   - **Exception Handling**:
     - `begin`: Code that might raise an exception.
     - `rescue ExceptionType => variable`: Code to handle the exception.
     - `else`: Code to execute if no exception occurs.
     - `ensure`: Code that will always execute (e.g., cleanup).

3. **Client-Server Architecture**: A model where clients (browsers) request resources from servers, which process and return responses. Client and Server communicate with the same protocol to understand each other. The most common protocol is HTTP. They are connected via a TCP network. e.g., `client-server`.

4. **Domain Name**: A human-readable address (e.g., `example.com`) that maps to an IP address for accessing websites.

5. **HTTP Request & Response**:
   - **WEBrick**: A Ruby web server library. e.g., `webrick-server`.
   - **Rack**: A Ruby library that interfaces web servers with frameworks like Sinatra. e.g., `simple-framework`.
   - **Sinatra**: A lightweight web application framework. e.g., `cookies`.
   - **Puma**: A high-performance Ruby web server.

7. **Web Server**: Handles HTTP requests (e.g., NGINX, Apache).
8. **Application Server**: Runs application logic and processes data (e.g., Puma, Unicorn).

<img src="diagrams/full_client-server_architecture.png" alt="Client-Server Architecture"/>

   - **URL Resolution Process**:
     - The browser identifies the domain name from the URL and starts resolving its IP address.
     - First, it checks the browser's DNS cache for a previous record.
     - If not found, it searches the OS DNS cache.
     - If still not found, it queries the ISP DNS cache.
     - Finally, the ISP uses a DNS resolver to perform a recursive DNS query to DNS servers (e.g., root server, authority server).
     - After obtaining the IP address, it connects via a TCP network with the host using a specific port, creating a socket on each side.
     - After successfully establishing the TCP connection, the HTTP request is sent.
     - The web server handles the request:
       - Public assets like images, CSS, and static HTML are directly sent as HTTP responses.
       - Dynamic requirements are forwarded to the application server as reverse proxy requests, which return an HTTP response.

8. **Storage**:
   - **Local Storage**: Persistent key-value storage in the browser.
   - **Session Storage**: Temporary key-value storage per browser tab.
   - **Cache Storage**: Stores HTTP responses for offline or faster access.
   - **Indexed DB**: A low-level database for structured data in browsers.
   - **Private State Token**: Stores private, origin-specific client data.

10. **HTTP Cookies**:
   - **Signed vs Unsigned Cookies**: Signed cookies ensure integrity using a cryptographic signature.
   - **Persistent vs Session Cookies**: Persistent cookies have an expiration date; session cookies last until the browser closes.
   - **Zombie Cookies**: Persistent cookies that regenerate after deletion.
   - **First-Party vs Third-Party Cookies**: First-party cookies belong to the site you're visiting; third-party cookies come from external domains.
   - **Secure Cookies**: Transmitted only over HTTPS.
   - **HttpOnly Cookies**: Inaccessible to JavaScript for security.
   - **SameSite Attribute**: Restricts cross-site cookie behavior (Strict, Lax, None).

<img src="diagrams/cookies.png" alt="Cookies Diagram"/>

   - **How Cookies Work**:
     - When an HTTP request is received by the server, it responds with HTTP and sets cookies.
     - Session cookies are stored in RAM, while persistent cookies are stored on disk.
     - According to user preferences, cookies store values that are sent in subsequent HTTP requests.
     - The server checks the cookies and responds according to the user's value in the cookies.
     - Optionally, cookie values are stored for future analysis, though this is less common.

11. **REST API**:
   - **Definition**: REST (Representational State Transfer) is an architectural style that uses standard HTTP methods to interact with resources.
   - **Resource-based**: Each endpoint represents a specific resource (e.g., `/users`, `/posts`).
   - **Fixed Data Structure**: Responses are predefined and might return more or less data than needed.
   - **Multiple Requests**: Fetching nested or related data often requires multiple requests.
   - **Caching**: Built-in HTTP caching mechanisms are straightforward to implement.

   ### **Advantages**:
   - Simpler to implement.
   - Standardized and widely adopted.
   - Works well with traditional RESTful systems.

   ### **Disadvantages**:
   - Over-fetching or under-fetching data.
   - Endpoints can become bloated with multiple versions or special cases.

---

12. **GraphQL**:
   - **Definition**: GraphQL is a query language for APIs that allows clients to request exactly the data they need.
   - **Single Endpoint**: Typically uses one endpoint (e.g., `/graphql`).
   - **Customizable Queries**: Clients specify what data they need, avoiding over-fetching or under-fetching.
   - **Nested Data**: Easily retrieves related or nested data in a single query.
   - **No Built-in Caching**: Requires manual implementation or third-party libraries for caching.

   ### **Advantages**:
   - Flexible and efficient data retrieval.
   - Reduces the number of API requests.
   - Self-documenting through introspection.

   ### **Disadvantages**:
   - More complex to implement.
   - Requires additional tools for features like caching and rate-limiting.

---

12. **Authentication and Authorization**:

   ## **Authentication**
   - **Definition**: Verifying the identity of a user or system.
   - **Common Methods**:
     - Username and password.
     - Token-based (e.g., JSON Web Tokens - JWT).
     - OAuth/OAuth2 (e.g., Google or Facebook login).
     - API Keys.

   ### **Best Practices**:
   - Use HTTPS to secure credentials.
   - Store passwords using hashing algorithms like bcrypt.
   - Implement multi-factor authentication (MFA).
   - Expire and rotate tokens regularly.

---

   ## **Authorization**
   - **Definition**: Determining what actions a user or system is allowed to perform.
   - **Examples**:
     - Role-based access control (RBAC).
     - Attribute-based access control (ABAC).
     - Permission levels (e.g., Admin, User, Guest).

   ### **Best Practices**:
   - Follow the principle of least privilege.
   - Use middleware to enforce authorization logic.
   - Keep authorization checks server-side to avoid client manipulation.

---

### **Authentication vs Authorization**
| Feature          | Authentication                   | Authorization                  |
|------------------|----------------------------------|---------------------------------|
| **Definition**   | Verifies identity of the user.   | Determines user permissions.   |
| **Purpose**      | "Who are you?"                  | "What are you allowed to do?" |
| **Sequence**     | Comes first.                     | Comes after authentication.    |

