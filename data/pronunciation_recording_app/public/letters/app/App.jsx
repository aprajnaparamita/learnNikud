import React from 'react';
import Table from './Table.jsx';

export default class App extends React.Component {
    constructor(props){
      super(props);

      this.state={
        tableData:{}
      }

      var speaker_slug = null;
      if(window.location.hash) {
        speaker_slug = window.location.hash.replace("#", "");
      } else {
        alert("Error: Missing speaker ID.")
        return;
      }

      fetch('/sounds/'+speaker_slug+'.json')
        .then(response => response.json())
        .then(data => this.setData(data));
    }

  setData(data) {
    console.log("App.setData", data);
    this.setState({
      tableData: data
    });
  }

  render() {
      return (
          <div className="App">
            <Table data={this.state.tableData}/>
          </div>
        );
    }
}
