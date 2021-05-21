function getHeaders() {
  let headers = new window.Headers({
    "Accept": "application/javascript",
    "X-Requested-With": "XMLHttpRequest"
  })

  const csrfToken = document.head.querySelector("[name='csrf-token']").getAttribute("content");
  if (csrfToken) { headers.append("X-CSRF-Token", csrfToken); }

  return headers
}

export function createRequest(url, method = "get") {
  const request = new window.Request(url, {
    headers: getHeaders(),
    method: method,
    credentials: "same-origin"
  })
  return request
}
