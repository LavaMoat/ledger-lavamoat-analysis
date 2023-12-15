### about

this is an analysis of the ledger supplychain attack and how LavaMoat could have prevented it.

the vulnerability partially stems from [@ledgerhq/connect-kit-loader](https://www.npmjs.com/package/@ledgerhq/connect-kit-loader) injecting a script tag at runtime as part of its normal operation to load the latest version of [@ledgerhq/connect-kit](https://www.npmjs.com/package/@ledgerhq/connect-kit).

we consider `@ledgerhq/connect-kit-loader` a non-starter for a secure setup, and instead investigate the developer's ability to analyze policy changes when updating `@ledgerhq/connect-kit` to the compromised version.

### status

the analysis has just begun and is not ready.

### findings

policy under bad version `1.1.7`:

```json
{
  "resources": {
    "bad-ledgerhq-connect-kit-v1-1-7": {
      "globals": {
        "CoinbaseWalletConnector": true,
        "CryptoJS": true,
        "EthereumClient": true,
        "Swal": true,
        "Web3Modal": true,
        "alert": true,
        "arbitrum": true,
        "avalanche": true,
        "bsc": true,
        "celo": true,
        "configureChains": true,
        "connect": true,
        "console": true,
        "createConfig": true,
        "createWeb3Modal": true,
        "crypto": true,
        "customModalCode": true,
        "defaultWagmiConfig": true,
        "document": true,
        "ethers": true,
        "fantom": true,
        "fetch": true,
        "getAccount": true,
        "localStorage": true,
        "mainnet": true,
        "navigator": true,
        "optimism": "write",
        "polygon": true,
        "publicProvider": true,
        "seaport": true,
        "setInterval": true,
        "setTimeout": true,
        "signatureVersion": true,
        "switchNetwork": true,
        "updateWalletData": true,
        "w3mConnectors": true,
        "w3mProvider": true
      }
    }
  }
}
```

policy under good version `1.1.4`:
```json
{
  "resources": {
    "@ledgerhq/connect-kit": {
      "globals": {
        "AbortController": true,
        "Blob": true,
        "Buffer": true,
        "Element": true,
        "FileReader": true,
        "FormData": true,
        "HTMLFormElement": true,
        "MSApp": true,
        "MessageChannel": true,
        "Path2D": true,
        "SC_DISABLE_SPEEDY": true,
        "SuppressedError": true,
        "TextDecoder": true,
        "TextEncoder": true,
        "URL": true,
        "URLSearchParams.prototype.isPrototypeOf": true,
        "WebSocket": true,
        "XMLHttpRequest": true,
        "YT.PlayerState.BUFFERING": true,
        "YT.PlayerState.ENDED": true,
        "YT.PlayerState.PAUSED": true,
        "YT.PlayerState.PLAYING": true,
        "Zepto": true,
        "__REACT_DEVTOOLS_GLOBAL_HOOK__": true,
        "__webpack_nonce__": true,
        "addEventListener": true,
        "analytics": "write",
        "analyticsWriteKey": "write",
        "btoa": true,
        "cancelAnimationFrame": true,
        "clearInterval": true,
        "clearTimeout": true,
        "clipboardData": true,
        "console": true,
        "crypto": true,
        "define": true,
        "document": true,
        "event": true,
        "fetch": true,
        "innerWidth": true,
        "jQuery": true,
        "localStorage": true,
        "location.hash": true,
        "location.hostname": true,
        "location.href": true,
        "location.pathname": true,
        "location.search": true,
        "msCrypto": true,
        "navigator": true,
        "open": true,
        "performance": true,
        "prompt": true,
        "queueMicrotask": true,
        "removeEventListener": true,
        "reportError": true,
        "requestAnimationFrame": true,
        "segmentYoutubeOnReady": "write",
        "segmentYoutubeOnStateChange": "write",
        "setInterval": true,
        "setTimeout": true
      },
      "packages": {
        "browserify>process": true,
        "browserify>timers-browserify": true
      }
    },
    "browserify>process": {
      "globals": {
        "clearTimeout": true,
        "setTimeout": true
      }
    },
    "browserify>timers-browserify": {
      "globals": {
        "clearInterval": true,
        "clearTimeout": true,
        "setInterval": true,
        "setTimeout": true
      },
      "packages": {
        "browserify>process": true
      }
    }
  }
}
```

diff if globals:
```diff
2,34c2,13
<   "AbortController": true,
<   "Blob": true,
<   "Buffer": true,
<   "Element": true,
<   "FileReader": true,
<   "FormData": true,
<   "HTMLFormElement": true,
<   "MSApp": true,
<   "MessageChannel": true,
<   "Path2D": true,
<   "SC_DISABLE_SPEEDY": true,
<   "SuppressedError": true,
<   "TextDecoder": true,
<   "TextEncoder": true,
<   "URL": true,
<   "URLSearchParams.prototype.isPrototypeOf": true,
<   "WebSocket": true,
<   "XMLHttpRequest": true,
<   "YT.PlayerState.BUFFERING": true,
<   "YT.PlayerState.ENDED": true,
<   "YT.PlayerState.PAUSED": true,
<   "YT.PlayerState.PLAYING": true,
<   "Zepto": true,
<   "__REACT_DEVTOOLS_GLOBAL_HOOK__": true,
<   "__webpack_nonce__": true,
<   "addEventListener": true,
<   "analytics": "write",
<   "analyticsWriteKey": "write",
<   "btoa": true,
<   "cancelAnimationFrame": true,
<   "clearInterval": true,
<   "clearTimeout": true,
<   "clipboardData": true,
---
>   "CoinbaseWalletConnector": true,
>   "CryptoJS": true,
>   "EthereumClient": true,
>   "Swal": true,
>   "Web3Modal": true,
>   "alert": true,
>   "arbitrum": true,
>   "avalanche": true,
>   "bsc": true,
>   "celo": true,
>   "configureChains": true,
>   "connect": true,
35a15,16
>   "createConfig": true,
>   "createWeb3Modal": true,
37c18,19
<   "define": true,
---
>   "customModalCode": true,
>   "defaultWagmiConfig": true,
39c21,22
<   "event": true,
---
>   "ethers": true,
>   "fantom": true,
41,42c24
<   "innerWidth": true,
<   "jQuery": true,
---
>   "getAccount": true,
44,49c26
<   "location.hash": true,
<   "location.hostname": true,
<   "location.href": true,
<   "location.pathname": true,
<   "location.search": true,
<   "msCrypto": true,
---
>   "mainnet": true,
51,59c28,31
<   "open": true,
<   "performance": true,
<   "prompt": true,
<   "queueMicrotask": true,
<   "removeEventListener": true,
<   "reportError": true,
<   "requestAnimationFrame": true,
<   "segmentYoutubeOnReady": "write",
<   "segmentYoutubeOnStateChange": "write",
---
>   "optimism": "write",
>   "polygon": true,
>   "publicProvider": true,
>   "seaport": true,
61c33,38
<   "setTimeout": true
---
>   "setTimeout": true,
>   "signatureVersion": true,
>   "switchNetwork": true,
>   "updateWalletData": true,
>   "w3mConnectors": true,
>   "w3mProvider": true
```


This is a significant change in the policy between minor versions of a package and should invite further scrutiny into the change.

However both versions include access to `document`, a very powerful API. Access to the document allows you to:
  - modify any part of the page
  - (indirectly) access any global (unless [scuttling][scuttling] is enabled)



[scuttling]: https://github.com/LavaMoat/LavaMoat/blob/main/docs/scuttling.md
