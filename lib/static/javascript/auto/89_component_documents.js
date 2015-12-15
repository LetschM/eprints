<<<<<<< HEAD
var Component_Documents = Class.create(Lightbox, {
	prefix: null,
	panels: null,
	documents: Array(),

	initialize: function(prefix) {
		this.prefix = prefix;
		this.panels = $(prefix + '_panels');
		Component_Documents.instances.push (this);

		var component = this;

		var form = this.panels.up('form');
		this.form = form;

		this.panels.select ('div.ep_upload_doc').each(function (doc_div) {
			var docid = component.initialize_panel (doc_div);

			component.documents.push ({
				id: docid,
				div: doc_div
			});
		});
=======
var Component_Documents = Class.create({
	prefix: null,
	container: null,
	documents: {},

	initialize: function(prefix) {
		this.prefix = prefix;
		this.container = $(prefix + '_panel');
		this.form = this.container.up('form');

		this.resizeDuration = LightboxOptions.animate ? ((11 - LightboxOptions.resizeSpeed) * 0.15) : 0;

		this.container.select ('div.ep_upload_doc').each((function (doc_div) {
      var doc = new Component_Documents.Document (this, doc_div.id);
      this.documents[doc.docid] = doc;
		}).bind(this));
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

		this.format = '^' + this.prefix + '_doc([0-9]+)';
		this.initialize_sortable();

<<<<<<< HEAD
		// Lightbox options
		this.lightbox = $('lightbox');
		this.overlay = $('overlay');
		this.loading = $('loading');
		this.lightboxMovie = $('lightboxMovie');
		this.resizeDuration = LightboxOptions.animate ? ((11 - LightboxOptions.resizeSpeed) * 0.15) : 0;
		this.overlayDuration = LightboxOptions.animate ? 0.2 : 0;
		this.outerImageContainer = $('outerImageContainer');
	},
	initialize_sortable: function() {
		Sortable.create (this.panels.id, {
=======
		Component_Documents.instances.push (this);
	},

	initialize_sortable: function() {
		Sortable.create (this.container, {
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
			tag: 'div',
			only: 'ep_upload_doc',
			format: this.format,
			onUpdate: this.drag.bindAsEventListener (this)
		});
	},
<<<<<<< HEAD
	initialize_panel: function(panel) {
		var component = this;

		var exp = 'input[name="'+component.prefix+'_update_doc"]';
		var docid;
		panel.select (exp).each(function (input) {
			docid = input.value
		});

		panel.select ('input[rel="interactive"]', 'input[rel="automatic"]').each(function (input) {
			var type = input.getAttribute ('rel');
			var attr = input.attributesHash ();
			attr['href'] = 'javascript:';
			var link = new Element ('a', attr);
			var img = new Element ('img', {
				src: attr['src']
			});
			link.appendChild (img);

			Event.observe( link, 'click', this.start.bindAsEventListener(this, link, docid, type ) );

			input.replace (link);
		}.bind(this));

		return docid;
	},
	find_document_div: function(docid) {
		return $(this.prefix + '_doc' + docid + '_block');
	},
	order: function() {
		var query = Sortable.serialize (this.panels, {
=======

  /* calculate the order of the documents according to Sortable */
	order: function() {
		var query = Sortable.serialize (this.container, {
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
			tag: 'div',
			format: this.format
		});
		var parts = query.split ('&');
		var docids = Array();
		$A(parts).each(function(part) {
			docids.push (part.split ('=')[1]);
		});
		return docids;
	},
<<<<<<< HEAD
	drag: function(panels) {
=======

  /* drag-end for Sortable */
	drag: function(container) {
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		var url = eprints_http_cgiroot + '/users/home';

		var action = '_internal_' + this.prefix + '_reorder';

		var params = serialize_form (this.form);
		params['component'] = this.prefix;
		params[this.prefix + '_order'] = this.order();
		params[action] = 1;

		new Ajax.Request(url, {
			method: 'get',
			onException: function(req, e) {
				throw e;
			},
			onSuccess: (function(transport) {
			}).bind (this),
			parameters: params
		});
	},
<<<<<<< HEAD
	start: function(event, input, docid, type) {

		var component = this;

		var action = input.name;

		var url = eprints_http_cgiroot + '/users/home';

		var params = serialize_form( this.form );
		params['component'] = this.prefix;
		params[this.prefix + '_update_doc'] = docid;
		params[this.prefix + '_export'] = docid;
		params[action] = 1;

		if (type == 'automatic')
		{
			new Ajax.Request(url, {
				method: 'post',
				onException: function(req, e) {
					throw e;
				},
				onSuccess: (function(transport) {
					var json = transport.responseJSON;
					if (!json)
					{
						alert ('Expected JSON but got: ' + transport.responseText);
						return;
					}
					this.update_documents (json.documents);
					this.update_messages (json.messages);
				}).bind (this),
				parameters: params
			});
			return;
		}

        $$('select', 'object', 'embed').each(function(node){ node.style.visibility = 'hidden' });

        var arrayPageSize = this.getPageSize();
        this.overlay.setStyle({
			width: arrayPageSize[0] + 'px',
			height: arrayPageSize[1] + 'px'
		});

        new Effect.Appear(this.overlay, { duration: this.overlayDuration, from: 0.0, to: LightboxOptions.overlayOpacity });

        // calculate top and left offset for the lightbox 
        var arrayPageScroll = document.viewport.getScrollOffsets();
        var lightboxTop = arrayPageScroll[1] + (document.viewport.getHeight() / 10);
        var lightboxLeft = arrayPageScroll[0];
        $('lightboxImage').hide();
        this.lightboxMovie.hide();
		$('hoverNav').hide();
        $('prevLink').hide();
        $('nextLink').hide();
        $('imageDataContainer').setStyle({opacity: .0001});
		this.lightbox.setStyle({ top: lightboxTop + 'px', left: lightboxLeft + 'px' }).show();

		new Ajax.Request(url, {
			method: 'post',
			onException: function(req, e) {
				throw e;
			},
			onSuccess: (function(transport) {
				this.loading.hide();
				$('lightboxMovie').update (transport.responseText);
			
				var boxWidth = this.lightboxMovie.getWidth();
				if( boxWidth == null || boxWidth < 640 )
					boxWidth = 640;
				this.resizeImageContainer ( boxWidth, this.lightboxMovie.getHeight());
				var form = $('lightboxMovie').down ('form');
				if (!form.onsubmit)
				{
					form.onsubmit = function() { return false; };
					form.select ('input[type="submit"]', 'input[type="image"]').each (function (input) {
						input.observe ('click',
							component.stop.bindAsEventListener (component, input)
						);
					});
				}
				$('lightboxMovie').show();
			}).bind (this),
			parameters: params
		});
	},
	stop: function(event, input) {

		var form = input.up ('form');
		var params = serialize_form( form );

		params[input.name] = 1;
		params['export'] = 1;

		this.lightboxMovie.hide();
		this.lightboxMovie.update ('');
		this.loading.show();

		var url = eprints_http_cgiroot + '/users/home';
		new Ajax.Request(url, {
			method: form.method,
			onException: function(req, e) {
				throw e;
			},
			onSuccess: (function(transport) {
				this.end();
				var json = transport.responseJSON;
				if (!json)
				{
					alert ('Expected JSON but got: ' + transport.responseText);
					return;
				}
				this.update_documents (json.documents);
				this.update_messages (json.messages);
			}).bind (this),
			parameters: params
		});
	},
	resizeImageContainer: function(imgWidth, imgHeight) {

        // get new width and height
        var widthNew  = (imgWidth  + LightboxOptions.borderSize * 2);
        var heightNew = (imgHeight + LightboxOptions.borderSize * 2);

	this.outerImageContainer.setStyle({ width: widthNew + 'px' });
	this.outerImageContainer.setStyle({ height: heightNew + 'px' });
	},
	update_messages: function(json) {
		var container = $('ep_messages');
		if (!container) return; // odd
=======

	update_messages: function(json) {
		var container = $('ep_messages');
    if (!container) {
      throw new Error ('ep_messages container missing');
    }
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		container.update ('');
		for(var i = 0; i < json.length; ++i)
			container.insert (json[i]);
	},
<<<<<<< HEAD
	remove_document: function(docid) {
		var doc_div = this.find_document_div (docid);
		if (!doc_div)
			return false;
		new Effect.SlideUp (doc_div, {
			duration: this.resizeDuration,
			afterFinish: (function() {
				doc_div.remove();
			}).bind (this)
		});
		return true;
	},
=======

	remove_document: function(docid) {
    var doc = this.documents[docid];
    this.documents[docid] = undefined;
		if (!doc)
			return false;
    doc.remove ();
    return true;
	},

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	update_documents: function(json) {
		var corder = this.order();
		var actions = Array();
		// remove any deleted
		for (var i = 0; i < corder.length; ++i)
			for (var j = 0; j <= json.length; ++j)
				if (j == json.length )
				{
					this.remove_document (corder[i]);
					corder.splice (i, 1);
					--i;
				}
				else if (corder[i] == json[j].id)
					break;
		// add any new or any forced-refreshes
		for (var i = 0; i < json.length; ++i)
			for (var j = 0; j <= corder.length; ++j)
				if (json[i].refresh)
				{
					this.refresh_document (json[i].id);
					break;
				}
				else if (j == corder.length)
				{
					this.refresh_document (json[i].id);
					corder.push (json[i].id);
					break;
				}
				else if (json[i].id == corder[j])
					break;
		// bubble-sort to reorder the documents in the order given in json
		var place = {};
		for (var i = 0; i < json.length; ++i)
			place[json[i].id] = parseInt (json[i].placement);
		var swapped;
		do {
			swapped = false;
			for (var i = 0; i < corder.length-1; ++i)
				if (place[corder[i]] > place[corder[i+1]])
				{
					this.swap_documents (corder[i], corder[i+1]);
					var t = corder[i];
					corder[i] = corder[i+1];
					corder[i+1] = t;
					swapped = true;
				}
		} while (swapped);
	},
	swap_documents: function(left, right) {
<<<<<<< HEAD
		left = this.find_document_div (left);
		right = this.find_document_div (right);
/*		left.parentNode.removeChild (left);
		right.parentNode.insertBefore (left, right.nextSibling);
		return; */
=======
		left = this.documents[left].container;
		right = this.documents[right].container;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		new Effect.SlideUp(left, {
			duration: this.resizeDuration,
			queue: 'end',
			afterFinish: function() {
				left.remove();
				right.parentNode.insertBefore (left, right.nextSibling);
			}
		});
		new Effect.SlideDown(left, {
			duration: this.resizeDuration,
			queue: 'end',
			afterFinish: (function() {
				this.initialize_sortable();
			}).bind (this)
		});
	},
<<<<<<< HEAD
	refresh_document: function(docid) {
		var params = serialize_form (this.form);

		params['component'] = this.prefix;
		delete params[this.prefix + '_update_doc'];
		params[this.prefix + '_export'] = docid;

		/* create an empty div that will hold the document */
		var doc_div = this.find_document_div (docid);
		if (!doc_div)
		{
			doc_div = Builder.node ('div', {
				id: this.prefix + '_doc' + docid + '_block',
				'class': 'ep_upload_doc'
			});
			this.panels.appendChild (doc_div);
		}
		else
		{
			doc_div.insertBefore (new Element ('img', {
				src: eprints_http_root + '/style/images/lightbox/loading.gif',
				style: 'position: absolute;'
			}), doc_div.firstChild );
		}

		var url = eprints_http_cgiroot + '/users/home';
		new Ajax.Request(url, {
			method: this.form.method,
			onException: function(req, e) {
				throw e;
			},
			onSuccess: (function(transport) {
				var div = Builder.node ('div');
				div.update (transport.responseText);
				div = $(div.firstChild);

				div.hide();
				this.initialize_panel (div);

				if (doc_div.hasChildNodes)
				{
					div.show ();
					doc_div.replace (div);
					this.initialize_sortable ();
				}
				else
				{
					doc_div.replace (div);

					new Effect.SlideDown (div, {
						duration: this.resizeDuration,
						afterFinish: (function() {
							this.initialize_sortable();
						}).bind (this)
					});
				}
			}).bind (this),
			onFailure: (function(transport) {
				if (transport.status == 404)
					if (this.remove_document (docid))
						this.initialize_sortable();
			}).bind (this),
			parameters: params
		});
	}
});
Component_Documents.instances = $A(Array());
=======

	refresh_document: function(docid) {
    var doc = this.documents[docid];

    if (doc) {
      doc.refresh ();
    }
    else {
      this.addDocument (docid);
    }
  },

  addDocument: function(docid) {
    var params = serialize_form (this.form);

    params['component'] = this.prefix;
    params[this.prefix + '_export'] = docid;

    var url = eprints_http_cgiroot + '/users/home';
    new Ajax.Request(url, {
      method: this.form.method,
      onException: function(req, e) {
        throw e;
      },
      onSuccess: (function(transport) {
        var prefix = this.prefix + '_doc' + docid;
        var div = new Element ('div', {
          id: prefix,
          'class': 'ep_upload_doc'
        });
        div.hide ();
        this.container.appendChild (div);

        div.update (transport.responseText);
        this.documents[docid] = new Component_Documents.Document (this, prefix);

        new Effect.SlideDown (div, {
          duration: this.resizeDuration,
          afterFinish: (function() {
            this.initialize_sortable();
          }).bind (this)
        });
      }).bind (this),
      parameters: params
    });
	}
});
Component_Documents.instances = $A(Array());

Component_Documents.Document = Class.create({
  initialize: function(component, prefix) {
    this.component = component;
    this.prefix = prefix;
    this.container = $(prefix);
    this.docid = $F(prefix + '_docid');
		this.progress_table = $(this.prefix + '_progress_table');

    this.initialize_panel();

		this.parameters = new Hash({
			screen: $F('screen'),
			eprintid: $F('eprintid'),
			stage: $F('stage'),
			component: this.component.prefix,
      _CSRF_Token: $F('_CSRF_Token')
		});
  },

  /* replace inputs with javascript widgets */
	initialize_panel: function() {
    this.container.select ('input[rel="automatic"]').each (function (input) {
      input.observe ('click', this.openAutomatic.bindAsEventListener (this, input));
    }.bind (this));

    this.container.select ('input[rel="interactive"]').each (function (input) {
      input.observe ('click', this.openInteractive.bindAsEventListener (this, input));
    }.bind (this));

    new EPrints.DragAndDrop.Files (this, $(this.prefix + '_dropbox'), $(this.prefix + '_content'));
	},

  openAutomatic: function(event, input) {
    var docid = this.docid;
    var component = this.component;

    event.stop();

		var url = eprints_http_cgiroot + '/users/home';

    var params = serialize_form (this.component.form);

		params['component'] = component.prefix;
		params[component.prefix + '_update'] = docid;
		params[component.prefix + '_export'] = docid;
		params[input.name] = 1;

    new Ajax.Request(url, {
      method: 'post',
      onException: function(req, e) {
        throw e;
      },
      onSuccess: (function(transport) {
        var json = transport.responseJSON;
        if (!json) {
          throw new Error ('Expected JSON but got: ' + transport.responseText);
        }
        component.update_documents (json.documents);
        component.update_messages (json.messages);
      }).bind (this),
      parameters: params
    });
  },

	openInteractive: function(event, input) {
    var docid = this.docid;
    var component = this.component;

    event.stop();

		var url = eprints_http_cgiroot + '/users/home';

		var params = serialize_form( this.component.form );

		params['component'] = component.prefix;
		params[component.prefix + '_update'] = docid;
		params[component.prefix + '_export'] = docid;
		params[input.name] = 1;

    new Lightbox.Dialog ({
      onShow: (function(dialog) {
        new Ajax.Request(url, {
          method: 'post',
          onException: function(req, e) {
            throw e;
          },
          onSuccess: (function(transport) {
            dialog.update (transport.responseText);
          
            var form = dialog.content.down ('form');
            if (form && !form.onsubmit)
            {
              form.onsubmit = function() { return false; };
              form.select ('input[type="submit"]', 'input[type="image"]').each (function (input) {
                input.observe ('click', this.closeInteractive.bindAsEventListener (this, dialog, input));
              }.bind (this));
            }
          }).bind (this),
          parameters: params
        });
      }).bind (this)
    });
	},

	closeInteractive: function(event, dialog, input) {
    var component = this.component;

		var form = input.up ('form');
		var params = serialize_form( form );

		params[input.name] = 1;
		params['export'] = 1;

    dialog.update ('');

		var url = eprints_http_cgiroot + '/users/home';

		new Ajax.Request(url, {
			method: form.method,
			onException: function(req, e) {
				throw e;
			},
			onSuccess: (function(transport) {
				dialog.end();

				var json = transport.responseJSON;
				if (!json) {
          throw new Error ('Expected JSON but got: ' + transport.responseText);
        }

				component.update_documents (json.documents);
				component.update_messages (json.messages);
			}).bind (this),
			parameters: params
		});
	},

  drop: function(evt, files) {
    if (files.length == 0)
      return;

    this.handleFiles (files);
  },

	handleFiles: function(files) {
		// User dropped a lot of files, did they really mean to?
		if( files.length > 5 )
		{
			eprints.currentRepository().phrase (
				{
					'Plugin/Screen/EPrint/UploadMethod/File:confirm_bulk_upload': {
						'n': files.length
					}
				},
				(function(phrases) {
					if (confirm(phrases['Plugin/Screen/EPrint/UploadMethod/File:confirm_bulk_upload']))
						for(var i = 0; i < files.length; ++i)
							this.createFile (files[i]);
				}).bind (this)
			);
		}
		else
			for(var i = 0; i < files.length; ++i)
				this.createFile (files[i]);
	},
	createFile: function(file) {
		// progress status
		var progress_row = new Element ('tr');
		file.progress_container = progress_row;

		// file name
		progress_row.insert (new Element ('td').update (file.name));

		// file size
		progress_row.insert (new Element ('td').update (human_filesize (file.size)));

		// progress bar
		var td = new Element ('td');
		progress_row.insert (td);
		file.progress_bar = new EPrintsProgressBar ({}, td);

		// progress text
		file.progress_info = new Element ('td');
		progress_row.insert (file.progress_info);

		// cancel button
		var button = new Element ('button', {
				'type': 'button',
				'class': 'ep_form_internal_button',
				'style': 'display: none'
			});
		Event.observe (button, 'click', (function (evt) {
				Event.stop (evt);
				this.abortFile (file);
			}).bind(this));
		file.progress_button = button;
		progress_row.insert (new Element ('td').update (button));

		this.progress_table.insert (progress_row);

		this.updateProgress (file, 0);

    var url = eprints_http_root + '/id/document/' + this.docid;

    new Ajax.Request(url, {
      method: 'get',
      requestHeaders: {
        'Accept': 'application/json'
      },
			onException: function(req, e) {
				throw e;
			},
      onSuccess: (function(transport) {
        var json = transport.responseJSON;
        if (!json) {
          throw new Error('Expected JSON but got: ' + transport.responseText);
        }

        // does this file already exist?
        var epdata;
        if (json.files) {
          for(var i = 0; i < json.files.length; ++i)
          {
            if (json.files[i].filename == file.name) {
              epdata = json.files[i];
              break;
            }
          }
        }

        if (epdata) {
          file.docid = this.docid;
          file.fileid = epdata.fileid;
          this.postFile (file, epdata.filesize);
        }
        else {
          var url = eprints_http_root + '/id/document/' + this.docid + '/contents';
          var params = this.parameters.clone();

          var bufsize = 1048576;
          var buffer = file.slice (0, bufsize);

          new Ajax.Request(url, {
            method: 'post',
            contentType: file.type,
            requestHeaders: {
              'Content-Range': '0-' + (buffer.size-1) + '/' + file.size,
              'Content-Disposition': 'attachment; filename=' + file.name,
              'Accept': 'application/json'
            },
            onException: function(req, e) {
              throw e;
            },
            onSuccess: (function(transport) {
              var json = transport.responseJSON;
              if (!json) {
                throw new Error('Expected JSON but got: ' + transport.responseText);
              }
              file.docid = json['objectid'];
              file.fileid = json['fileid'];
              /* button.update (json['phrases']['abort']);
              button.show(); */
              this.postFile (file, buffer.size);
            }).bind (this),
            parameters: params,
            postBody: buffer
          });
        }
      }).bind (this)
    });
	},
	/*
	 * POST the content of the file to the server via CRUD
	 */
	postFile: function(file, offset) {
		var params = this.parameters.clone();
		var url = eprints_http_root + '/id/file/' + file.fileid;

		var bufsize = 1048576;
		var buffer = file.slice (offset, offset + bufsize);

		// finished
		if (buffer.size == 0)
		{
			this.finishFile (file);
			return;
		}

		new Ajax.Request(url, {
			method: 'put',
			onException: function(req, e) {
				throw e;
			},
			onFailure: function(transport) {
				throw new Error('Server reported failure: ' + transport.status);
			},
			onSuccess: (function(transport) {
				if (file.abort)
					return;
				this.updateProgress (file, offset);
				this.postFile (file, offset + bufsize);
			}).bind (this),
      contentType: file.type,
			requestHeaders: {
				'Content-Range': '' + offset + '-' + (offset + buffer.size) + '/' + file.size,
				'X-Method': 'PUT'
			},
			postBody: buffer
		});
	},
	/*
	 * Tell the server we've finished updating the file e.g. perform file
	 * detection
	 */
	finishFile: function(file) {
		this.updateProgress (file, file.size);

    file.progress_container.parentNode.removeChild (file.progress_container);
    this.component.refresh_document (file.docid);
	},
	/*
	 * Abort and clean-up the file upload
	 */
	abortFile: function(file) {
		file.abort = true;
		file.progress_button.hide();

		if (!file.docid)
			return;

		var url = eprints_http_root + '/id/file/' + file.fileid;

		new Ajax.Request(url, {
			method: 'delete',
			onException: function(req, e) {
				throw e;
			},
			onFailure: function(transport) {
				throw new Error('Server reported failure: ' + transport.status);
			},
			onSuccess: (function(transport) {
				file.progress_container.parentNode.removeChild (file.progress_container);
			}).bind (this),
			requestHeaders: {
				'X-Method': 'DELETE'
			}
		});

		return false;
	},
	/*
	 * Update the progress bar + info for a single file
	 */
	updateProgress: function(file, n) {
		var percent = n / file.size;
		file.progress_bar.update (percent, Math.floor(percent*100) + '%');
		file.progress_info.update (Math.floor(percent*100) + '%');
	},

  refresh: function() {
		var params = serialize_form (this.component.form);

		params['component'] = this.component.prefix;
		params[this.component.prefix + '_export'] = this.docid;

    var url = eprints_http_cgiroot + '/users/home';
    new Ajax.Request(url, {
      method: this.component.form.method,
      onException: function(req, e) {
        throw e;
      },
      onFailure: (function(transport) {
        if (transport.status == 404) {
          this.component.remove_document (this.docid);
          this.component.initialize_sortable();
        }
      }).bind (this),
      onSuccess: (function(transport) {
        var progress_table = this.progress_table;
        progress_table.parentNode.removeChild (progress_table);

        this.container.update (transport.responseText);
        $(this.prefix + '_progress_table').replace (progress_table);

        this.initialize_panel();
      }).bind (this),
      parameters: params
    });
  },

  remove: function() {
		new Effect.SlideUp (this.container, {
			duration: this.component.resizeDuration,
			afterFinish: (function() {
				this.container.remove();
			}).bind (this)
		});
  }
});
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
