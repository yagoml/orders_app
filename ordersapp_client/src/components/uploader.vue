<template>
	<div class="fine-uploader">
		<script type="text/template" id="qq-template-manual-trigger">
			<div class="qq-uploader-selector qq-uploader" qq-drop-area-text="Arraste e solte arquivos aqui">
				<div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
					<span class="qq-upload-drop-area-text-selector"></span>
				</div>

				<div class="buttons">
					<button class="btn btn-default qq-upload-button-selector qq-upload-button">
						Selecionar
					</button>
					<button type="button" id="trigger-upload" class="btn btn-primary">
						Enviar
					</button>
				</div>
				<span class="qq-drop-processing-selector qq-drop-processing">
					<span>Processando arquivos selecionados...</span>
					<span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
				</span>

				<ul class="qq-upload-list-selector qq-upload-list" aria-live="polite" aria-relevant="additions removals">
					<li>
						<span class="qq-upload-spinner-selector qq-upload-spinner"></span>
						<img class="qq-thumbnail-selector" qq-max-size="100" qq-server-scale>
						<span class="qq-upload-file-selector qq-upload-file"></span>
						<span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
						<input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
						<span class="qq-upload-size-selector qq-upload-size"></span>
						<button type="button" class="qq-btn qq-upload-cancel-selector qq-upload-cancel">Cancelar</button>
						<button type="button" class="qq-btn qq-upload-retry-selector qq-upload-retry">Tentar novamente</button>
						<button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">Deletar</button>
						<span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
					</li>
				</ul>

				<div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
					<div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
				</div>

				<dialog class="qq-alert-dialog-selector">
					<div class="qq-dialog-message-selector"></div>
					<div class="qq-dialog-buttons">
						<button type="button" class="qq-cancel-button-selector">Close</button>
					</div>
				</dialog>

				<dialog class="qq-confirm-dialog-selector">
					<div class="qq-dialog-message-selector"></div>
					<div class="qq-dialog-buttons">
						<button type="button" class="qq-cancel-button-selector">No</button>
						<button type="button" class="qq-ok-button-selector">Yes</button>
					</div>
				</dialog>

				<dialog class="qq-prompt-dialog-selector">
					<div class="qq-dialog-message-selector"></div>
					<input type="text">
					<div class="qq-dialog-buttons">
						<button type="button" class="qq-cancel-button-selector">Cancel</button>
						<button type="button" class="qq-ok-button-selector">Ok</button>
					</div>
				</dialog>
			</div>
		</script>

		<div id="uploader"></div>
	</div>
</template>

<script>
	const qq = require('fine-uploader')
	require('style-loader!css-loader!fine-uploader/fine-uploader/fine-uploader-new.min.css')
	require('style-loader!css-loader!fine-uploader/fine-uploader/fine-uploader-gallery.min.css')

	export default {
		props: [ 'params' ],
		mounted() {
			this.uploader()
			qq(document.getElementById("trigger-upload")).attach("click", () => {
				this.uploadParams.numFiles = this.fineUploader.getUploads().length
				this.fineUploader.setParams(this.uploadParams)
				this.fineUploader.uploadStoredFiles()
			})
		},
		data() {
			return {
				uploadParams: {
					numFiles: 0
				}
			}
		},
		methods: {
			uploader() {
				this.uploadParams = Object.assign(this.uploadParams, this.params)

				this.fineUploader = new qq.FineUploader({
					element: document.getElementById("uploader"),
					autoUpload: false,
					multiple: false,
					template: 'qq-template-manual-trigger',
					deleteFile: {
						enabled: true,
						endpoint: `${ this.$store.getters.serverURL }uploads/delete`,
						method: 'POST',
						params: {
							id: ''
						}
					},
					request: {
						endpoint: `${ this.$store.getters.serverURL + this.params.endPoint }`,
						params: this.uploadParams
					},
					thumbnails: {
						placeholders: {
							waitingPath: `${ window.location.origin }/node_modules/fine-uploader/fine-uploader/placeholders/waiting-generic.png`,
							notAvailablePath: `${ window.location.origin }/node_modules/fine-uploader/fine-uploader/placeholders/not_available-generic.png`
						}
					},
					callbacks: {
						onAllComplete: (response) => {
							this.saveFileDb(response.fileDir)
						},
						onError: (id, name, errorReason, xhr) => {
							alert(JSON.parse(xhr.response).error)
						},
						onSessionRequestComplete: () => {
							// Callback ao carregar arquivos no server
							return
						}
					}
				})
			},
			saveFileDb(file) {

			}
		}
	}
</script>

<style lang='less'>
	.fine-uploader {
		.buttons {
			margin-bottom: 12px;
		}

		#trigger-upload {
			margin-left: 10px;
		}
		
		.qq-upload-file {
			width: fit-content;
		}

		.qq-uploader {
			.qq-total-progress-bar-container {
				margin-top: 12px;
				margin-left: 0;
				border: 1px solid #ccc;
				border-radius: 10px;
			}
		}
	}
</style>