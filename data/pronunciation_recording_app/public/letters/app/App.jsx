import React from 'react';
import Table from './Table.jsx';

export default class App extends React.Component {
    constructor(props){
      super(props);

      if (! (window.sessionStorage['legal'] == 'yes')) {
        var r = confirm("By using this system and submitting your recordings you are agreeing to following. Your recordings will be placed under the Creative Commons Attribution-ShareAlike 4.0 International License. Click Cancel if you want to view the license. You will be given credit for your work on your recordings but for legal purposes of distribution you assign your copyright to Janet Braswell-Jeffus (Yana.) Click Ok if you agree.");
        if (r == true) {
          window.sessionStorage['legal'] = 'yes';
          window.location.reload();
        } else {
          window.location.href = "http://creativecommons.org/licenses/by-sa/4.0/";
        }
        sessionStorage['myvariable'] = myVariable;
      }

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
