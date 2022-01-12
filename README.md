# Localazy GitHub Action

Upload translations to Localazy, publish and promote tags. 

## Inputs

### `workdir`

**Optional** Defines the working directory where to invoke Localazy CLI command.

### `config_file`

**Optional** The filename of the configuration file. Default: localazy.json

### `read_key`

**Optional** The read key for the project on Localazy. Can be also defined in the Localazy config file.

### `write_key`

**Optional** The write key for the project on Localazy. Can be also defined in the Localazy config file.

### `write_key`

**Optional** The write key for the project on Localazy. Can be also defined in the Localazy config file.

### `publish`

**Optional** JSON string containing a branch:tag map for tag publishing.

### `promote`

**Optional** JSON string containing a branch:[from,to] map for tag promoting.

## Example usage

```yaml
uses: MegaverseBE/localazy-action@v1
with:
  read_key: ${{ secrets.LOCALAZY_READ_KEY }}
  write_key: ${{ secrets.LOCALAZY_WRITE_KEY }}
  publish: '{ "development": "development" }'
  promote: '{ "master": { from: "development", to: "master" } }'
```
