var h1maintitle = { src: '/h1.swf' };
var h1title = { src: '/h1.swf' };

sIFR.activate(h1maintitle, h1title);

sIFR.replace(h1maintitle, {
	selector: 'h1.maintitle',
	wmode: 'transparent',
	css: '.sIFR-root { font-size: 36px; color: #1F1F1F; }'
});
sIFR.replace(h1title, {
	selector: 'h1.title',
	wmode: 'transparent',
	css: '.sIFR-root { font-size: 26px; color: #4D4D4D; }'
});