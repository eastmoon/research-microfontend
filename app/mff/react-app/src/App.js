import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
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
