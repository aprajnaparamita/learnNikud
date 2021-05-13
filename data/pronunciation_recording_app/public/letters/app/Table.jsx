import React from 'react';
import {
    record
} from "vmsg";

export default class Table extends React.Component {
    constructor(props){
      super(props);
      this.getRowsData = this.getRowsData.bind(this);
    }
  showControls = function() {
    document.getElementById('edit').setAttribute('class', 'shown');
    document.getElementById('editButton').setAttribute('class', 'hidden');
  };
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
        form.append("sound[examples]", document.getElementById('edit_example').value);
        form.append("sound[notes]", document.getElementById('notes').value);
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
        document.getElementById('edit_example').value = items['examples'] || '';
        document.getElementById('notes').value        = items['notes']    || '';
        return <tbody>
        <input type="hidden" id="id" value={items['id']} />
        <input type="hidden" id="filename" value={items['filename']} />
        <tr>
          <th colSpan="2">{items['speaker_name']} you are on {items['current']} of {items['total']}.</th>
        </tr>
        <tr>
          <th colSpan="2" class="main"><h1>{items['character']}</h1><p>{items['hebrew_name']}</p></th>
        </tr>
        <tr>
          <td colSpan="2" class="main">{items['hebrew_name']} is prounounced {items['character']} for example {items['examples'].replace(' ', ' or ')}.</td>
        </tr>
        <tr>
          <td colSpan="2" class="smaller">{items['nikud_hebrew_name']}: {items['nikud_description']}</td>
        </tr>
        </tbody>
      } else {
        return <tbody><tr key={index}></tr></tbody>
      }
    }
    render() {
        return (
          <div id="controls">
            <table>
              {this.getRowsData()}
            </table>
            <div id="audio"></div>
            <button id="deleteButton" onClick={this.deleteRecord} class="hidden">Reset</button>
            <button id="recordButton" onClick={this.startRecord} class="shown">Record</button>
            <button id="editButton" onClick={this.showControls} class="shown">Edit</button>
          </div>
        );
    }
}

