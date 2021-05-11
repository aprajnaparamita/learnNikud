import React from 'react';
import {
    record
} from "vmsg";

export default class Table extends React.Component {
    constructor(props){
      super(props);
      this.getRowsData = this.getRowsData.bind(this);
    }
  deleteRecord = function() {
        fetch("/sounds/"+ document.getElementById('id').value, {
          method: "DELETE",
        }).then(resp => {
          console.log("response", resp);
          window.location.reload();
        });
  }
  startRecord = function() {
      record({
        wasmURL: "/vmsg.wasm"
      }).then(blob => {
        console.log("Recorded MP3", blob);
        document.getElementById('deleteButton').setAttribute('class', 'shown');
        document.getElementById('recordButton').setAttribute('class', 'hidden');
          var url = URL.createObjectURL(blob);
          var audio = document.getElementById('audio')
          var preview = document.createElement('audio');
          preview.controls = true;
          preview.src = url;
          audio.innerHTML = '';
        audio.appendChild(preview);
        const form = new FormData();
        form.append("sound[id]", document.getElementById('id').value);
        form.append("sound[filename]", document.getElementById('filename').value);
        form.append("sound[example]", document.getElementById('edit_example').value);
        form.append("sound[blob]", blob, "record.mp3");
        fetch("/sounds/"+ document.getElementById('id').value, {
          method: "PUT",
          body: form,
        }).then(resp => {
          console.log("response", resp);
        });
      });
  }
    getRowsData = function(){
      var items = this.props.data['sound'];
      var index = 1;
      if (items) {
        document.getElementById('edit_example').value = items['examples'];
        return <tbody>
        <input type="hidden" id="id" value={items['id']} />
        <input type="hidden" id="filename" value={items['filename']} />
        <tr>
          <th colspan="2">{items['speaker_name']} you are on {items['current']} of {items['total']}.</th>
        </tr>
        <tr>
          <th colspan="2"><h1>{items['character']}</h1><p>{items['hebrew_name']}</p></th>
        </tr>
        <tr>
          <td colspan="2">{items['nikud_description']}</td>
        </tr>
        <tr>
          <td>Examples</td><td>{items['examples'].replace(' ', ' or ')}</td>
        </tr>
        </tbody>
      } else {
        return <tbody><tr key={index}></tr></tbody>
      }
    }
    render() {
        return (
          <div>
            <table>
              {this.getRowsData()}
            </table>
            <div id="audio"></div>
            <button id="deleteButton" onClick={this.deleteRecord} class="hidden">Reset</button>
            <button id="recordButton" onClick={this.startRecord} class="shown">Record</button>
          </div>
        );
    }
}

