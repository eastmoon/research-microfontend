import logo from './logo.svg';

function App() {
  const styles=`
  .App { text-align: center; }
  .App-logo {
    height: 20vmin;
    pointer-events: none;
    animation: App-logo-spin infinite 20s linear;
  }
  @keyframes App-logo-spin {
    from {
      transform: rotate(0deg);
    } to {
      transform: rotate(360deg);
    }
  }
  .App-header {
    background-color: #282c34;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: calc(10px + 2vmin);
    color: white;
  }`
  return (
    <div className="App">
      <style>{styles}</style>
      <header className="App-header">
        <div style={{display: "flex"}}>
          <img src={logo} className="App-logo" alt="logo" width="50px" />
          <span style={{margin: "auto"}}>React, Hello World!!!!</span>
        </div>
      </header>
    </div>
  );
}

export default App;
