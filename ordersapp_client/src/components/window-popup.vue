<template>
	<div class="window-popup" v-bind:style="visible">
		<div 
			id="windowContainer"
			v-bind:style="windowWidth"
		>
			<i class="glyphicon glyphicon-remove closeWindow" @click="close"></i>
			<div id="windowTitle">{{ title }}</div>
			<div id="windowContent">
				<slot></slot>
			</div>
			<div id="windowButtons" v-if="!extraButtons.length">
				<button id="close" @click="close" class="btn btn-default">{{ buttonsTexts.close }}</button>
				<button id="action" @click="action" class="btn btn-primary">{{ buttonsTexts.action }}</button>
			</div>
			<div id="windowButtons" v-else>
				<button v-for="extraButtom in extraButtons"
					:key="extraButtom.text"
					:class="extraButtom.class"
					@click="extraBtnAction(extraButtom.trigger)"
				>{{ extraButtom.text }}</button>

				<button id="close" @click="close" class="btn btn-default">{{ buttonsTexts.close }}</button>
				<button id="action" @click="action" class="btn btn-primary">{{ buttonsTexts.action }}</button>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		props: {
			width: {
				default: '50%',
				type: String
			},
			title: {
				default: '',
				type: String
			},
			extraButtons: {
				default() {
					return []
				},
				type: Array
			},
			buttonsTexts: {
				default() {
					return {
						close: 'Fechar',
						action: 'Confirmar'
					}
				},
				type: Object
			}
		},
		created() {

		},
		data() {
			return {
				visible: {
					display: 'none'
				},
				windowWidth: {
					width: 'auto'
				}
			}
		},
		methods: {
			open() {
				this.visible.display = 'flex'
				this.windowWidth.width = this.width
			},
			close() {
				this.visible.display = 'none'
				this.$emit('windowClosed')
			},
			action() {
				this.$emit('windowAction')
				this.close()
			},
			extraBtnAction(trigger) {
				this.$emit(trigger)
				this.close()
			}
		},
		computed: {
			
		}
	}
</script>

<style lang="less">
	.window-popup {
		display: none; /* Hidden by default */
		position: fixed; /* Stay in place */
		z-index: 1; /* Sit on top */
		justify-content: center; /* horizontal center */
		align-items: center;     /* vertical center */
		width: 100%; /* Full width */
		height: 100%; /* Full height */
		overflow: hidden; /* Enable scroll if needed */
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		top: 0;
		left: 0;

		textarea {
			resize: vertical;
		}

		#windowContainer {
			background: #eee;
			padding: 15px;
			height: auto;
			border: 1px solid #888;
			vertical-align: middle;
			width: fit-content;
			text-align: center;
			position: relative;

			#windowTitle {
				font-size: 17px;
				margin-bottom: 15px;
			}

			#windowContent {
				margin-bottom: 15px;
			}

			/* The Close Button */
			.closeWindow {
				color: rgba(119, 119, 119, .7);
				float: right;
				font-size: 15px;
				font-weight: bold;
				opacity: 1;
				position: absolute;
				top: 3px;
				right: 3px;
				cursor: pointer;

				&:hover, &:focus {
					color: rgba(169, 68, 66, 1);
					text-decoration: none;
					cursor: pointer;
					opacity: 1;
				}
			}

			#windowButtons {
				text-align: right;

				button {
					margin: 0 5px;
					
					&:nth-last-child(1) {
						margin-right: 0;
					}
				}
			}
		}
	}
</style>