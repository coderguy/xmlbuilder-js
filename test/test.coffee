assert = require('assert')
xmlbuilder = require '../src/index.coffee'

# Test XML
xml = '<root>' +
        '<xmlbuilder for="node-js">' +
          '<!-- CoffeeScript is awesome. -->' +
          '<repo type="git">git://github.com/oozcitak/xmlbuilder-js.git</repo>' +
        '</xmlbuilder>' +
        '<test escaped="chars &lt;&gt;&apos;&quot;&amp;">complete 100%</test>' +
        '<cdata><![CDATA[<test att="val">this is a test</test>\nSecond line]]></cdata>' +
        '<raw>&<>&</raw>' +
        '<atttest att="val">text</atttest>' +
        '<atttest>text</atttest>' +
      '</root>'

# Test long form
builder = xmlbuilder.create()
builder.begin('root')
  .ele('xmlbuilder')
    .att('for', 'node-js')
    .com('CoffeeScript is awesome.')
    .ele('repo')
      .att('type', 'git')
      .txt('git://github.com/oozcitak/xmlbuilder-js.git')
    .up()
  .up()
  .ele('test')
    .att('escaped', 'chars <>\'"&')
    .txt('complete 100%')
  .up()
  .ele('cdata')
    .cdata('<test att="val">this is a test</test>\nSecond line')
  .up()
  .ele('raw')
    .raw('&<>&')
    .up()
  .ele('atttest', { 'att': 'val' }, 'text')
    .up()
  .ele('atttest', 'text')

test = builder.toString()
assert.strictEqual(xml, test)

# Test long form with attributes
builder.begin('root')
  .ele('xmlbuilder', {'for': 'node-js' })
    .com('CoffeeScript is awesome.')
    .ele('repo', {'type': 'git'}, 'git://github.com/oozcitak/xmlbuilder-js.git')
    .up()
  .up()
  .ele('test', {'escaped': 'chars <>\'"&'}, 'complete 100%')
  .up()
  .ele('cdata')
    .cdata('<test att="val">this is a test</test>\nSecond line')
  .up()
  .ele('raw')
    .raw('&<>&')
    .up()
  .ele('atttest', { 'att': 'val' }, 'text')
    .up()
  .ele('atttest', 'text')

test = builder.toString()
assert.strictEqual(xml, test)

# Test short form
builder.begin('root')
  .e('xmlbuilder', {'for': 'node-js' })
    .c('CoffeeScript is awesome.')
    .e('repo', {'type': 'git'}, 'git://github.com/oozcitak/xmlbuilder-js.git')
    .u()
  .u()
  .e('test', {'escaped': 'chars <>\'"&'}, 'complete 100%')
  .u()
  .e('cdata')
    .d('<test att="val">this is a test</test>\nSecond line')
  .u()
  .e('raw')
    .r('&<>&')
    .u()
  .e('atttest', { 'att': 'val' }, 'text')
    .u()
  .e('atttest', 'text')

test = builder.toString()
assert.strictEqual(xml, test)

# Test multiple instances
xml2 = '<test2><node>second instance</node></test2>'
builder2 = xmlbuilder.create()
builder2.begin('test2')
  .ele('node', 'second instance')
test2 = builder2.toString()
assert.strictEqual(xml2, test2)

# First instance should remain unchanged
test1 = builder.toString()
assert.strictEqual(xml, test1)

