## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
312 sec
<br>
<sup><sub>(
5:12 min
)</sub></sup>
</p>

<br>
<!--
Note for image scripts:
  - Newlines are ignored
  - This characters cant be used: +<"%#
-->
<p align="center">
<img alt="Loading Timeline" src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [48.00]},
        {label: 'Construction\n', data: [52.00]},
        {label: 'PreInit\n', data: [143.00]},
        {label: 'Init\n', data: [64.00]},
    ]
  },
  options: {
    layout: { padding: { top: 10 } },
    scales: {
      xAxes: [{display: false, stacked: true}],
      yAxes: [{display: false, stacked: true}],
    },
    elements: {rectangle: {borderWidth: 2}},
    legend: {display: false},
    plugins: {datalabels: {
      color: 'white',
      font: {
        family: 'Consolas',
      },
      formatter: (value, context) =>
        [context.dataset.label, value, 's'].join('')
    }},
    annotation: {
      clip: false,
      annotations: [{
          type: 'line',
          scaleID: 'x-axis-0',
          value: 48,
          borderColor: 'black',
          label: {
            content: 'Window appear',
            fontSize: 8,
            enabled: true,
            xPadding: 8, yPadding: 2,
            yAdjust: -20
          },
        }
      ]
    },
  }
}"/>
</p>

<br>

# Mods Loading Time

<p align="center">
<img alt="Mods Loading Time" src="https://quickchart.io/chart.png?w=400&h=300&c={
  type: 'outlabeledPie',
  options: {
    rotation: Math.PI,
    cutoutPercentage: 25,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v,i)=>[
          v.labels[v.dataIndex],' ',
          (v.percent*1000|0)/10,
          String.fromCharCode(37)].join('')
      }
    }
  },
  data: {...
`
436e17 13.39s Had Enough Items;
395E14  6.73s [JEI Plugins];
5161a8  8.00s CraftTweaker2;
6a3eba  6.44s Ender IO CEu;
5A359E  1.53s [VF ModelBake];
8f304e  5.16s Astral Sorcery;
213664  4.64s Forestry;
1C2E55  1.35s [VF ModelBake];
cd922c  4.60s NuclearCraft;
a651a8  4.42s IndustrialCraft 2;
813e81  4.18s OpenComputers;
176e6e  3.84s Recurrent Complex Volts;
3e68ba  3.44s AE2 Unofficial Extended Life;
35589E  0.93s [VF ModelBake];
308f7e  2.70s Quark: RotN Edition;
ba3eb8  2.61s Cyclic;
a86e51  2.60s Extra Utilities 2;
3e8160  2.42s The Twilight Forest;
8c2ccd  2.45s Immersive Engineering;
306e8f  2.29s Custom Loading Screen;
444444 46.89s 30 Other mods;
333333 49.94s 161 'Fast' mods (1.0s - 0.1s);
222222  8.32s 295 'Instant' mods (%3C 0.1s)
`
    .split(';').reduce((a, l) => {
      l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s)
      .slice(1).map((a, i) => [[String.fromCharCode(35),a].join(''), a,
        a.length > 15 ? a.split(/(?%3C=.{9})\s(?=\S{5})/).join('\n') : a
      ][i])
      .forEach((s, i) =>
        [a.datasets[0].backgroundColor, a.datasets[0].data, a.labels][i].push(s)
      );
      return a
    }, {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 1
      }]
    })
  }
}"/>
</p>

<br>

# Loader steps

Show how much time each mod takes on each game load phase.

JEI/HEI not included, since its load time based on other mods and overal item count.

<p align="center">
<img alt="Loader Steps" src="https://quickchart.io/chart.png?w=400&h=450&c={
  options: {
    scales: {
      xAxes: [{stacked: true}],
      yAxes: [{stacked: true}],
    },
    plugins: {
      datalabels: {
        anchor: 'end',
        align: 'top',
        color: 'white',
        backgroundColor: 'rgba(46, 140, 171, 0.6)',
        borderColor: 'rgba(41, 168, 194, 1.0)',
        borderWidth: 0.5,
        borderRadius: 3,
        padding: 0,
        font: {size:10},
        formatter: (v,ctx) =>
          ctx.datasetIndex!=ctx.chart.data.datasets.length-1 ? null
            : [((ctx.chart.data.datasets.reduce((a,b)=>a- -b.data[ctx.dataIndex],0)*10)|0)/10,'s'].join('')
      },
      colorschemes: {
        scheme: 'office.Damask6'
      }
    }
  },
  type: 'bar',
  data: {...(() => {
    let a = { labels: [], datasets: [] };
`
0: Construction;
1: Loading Resources;
2: PreInitialization;
3: Initialization;
4: InterModComms;
5: LoadComplete;
6: ModIdMapping;
7: Other
`
    .split(';')
      .map(l => l.match(/\d: (.*)/).slice(1))
      .forEach(([name]) => a.datasets.push({ label: name, data: [] }));
`
                                  0      1      2      3      4      5      6      7;
CraftTweaker2                 | 0.22| 0.00| 3.21| 4.52| 0.00| 0.06| 0.00| 0.00;
Ender IO CEu                  | 0.92| 0.01| 2.29| 0.19| 1.49| 0.00| 0.01| 1.53;
Astral Sorcery                | 0.16| 0.00| 3.71| 1.29| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.35| 0.01| 1.98| 0.96| 0.00| 0.00| 0.00| 1.35;
NuclearCraft                  | 0.05| 0.01| 3.34| 1.18| 0.00| 0.00| 0.03| 0.00;
IndustrialCraft 2             | 0.42| 0.01| 3.06| 0.94| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.14| 0.01| 1.33| 2.07| 0.07| 0.00| 0.00| 0.28;
Recurrent Complex Volts       | 0.17| 0.00| 0.37| 3.30| 0.00| 0.00| 0.00| 0.00;
AE2 Unofficial Extended Life  | 0.08| 0.01| 1.71| 0.71| 0.01| 0.00| 0.00| 0.93;
Quark: RotN Edition           | 0.07| 0.01| 2.49| 0.13| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.07| 0.00| 0.16| 0.09| 0.00| 0.01| 0.00| 0.01
`
    .split(';').slice(1)
      .map(l => l.split('|').map(s => s.trim()))
      .forEach(([name, ...arr], i) => {
        a.labels.push(name);
        arr.forEach((v, j) => a.datasets[j].data[i] = v)
      }); return a
  })()}
}"/>
</p>

<br>

# TOP JEI Registered Plugis

<p align="center">
<img alt="TOP JEI Registered Plugis" src="https://quickchart.io/chart.png?w=500&h=200&c={
  options: {
    elements: { rectangle: { borderWidth: 1 } },
    legend: false,
    scales: {
      yAxes: [{ ticks: { fontSize: 9, fontFamily: 'Verdana' }}],
    },
  },
  type: 'horizontalBar',
    data: {...(() => {
      let a = {
        labels: [], datasets: [{
          backgroundColor: 'rgba(0, 99, 132, 0.5)',
          borderColor: 'rgb(0, 99, 132)',
          data: []
        }]
      };
`
 0.84: jeresources.jei.JEIConfig;
 0.72: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.64: com.buuz135.industrial.jei.JEICustomPlugin;
 0.47: ic2.jeiIntegration.SubModule;
 0.46: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.41: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.25: roidrole.thaumicinfo.HEIPlugin;
 0.21: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.20: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.19: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.16: ninjabrain.gendustryjei.GendustryJEIPlugin;
 0.13: net.bdew.jeibees.BeesJEIPlugin;
 2.05: Other
`
        .split(';')
        .map(l => l.split(':'))
        .forEach(([time, name]) => {
          a.labels.push(name);
          a.datasets[0].data.push(time)
        })
        ; return a
    })()
  }
}"/>
</p>

<br>

# FML Stuff

Loading bars that usually not related to specific mods.

⚠️ Shows only steps that took 1.0 sec or more.

<p align="center">
<img alt="FML Stuff" src="https://quickchart.io/chart.png?w=500&h=400&c={
  options: {
    rotation: Math.PI*1.125,
    cutoutPercentage: 55,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v)=>v.labels
      },
      doughnutlabel: {
        labels: [
          {
            text: 'FML stuff:',
            color: 'rgba(128, 128, 128, 0.5)',
            font: {size: 18}
          },
          {
            text: '124.00s',
            color: 'rgba(128, 128, 128, 1)',
            font: {size: 22}
          }
        ]
      },
    }
  },
  type: 'outlabeledPie',
  data: {...(() => {
    let a = {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 2
      }]
    };
`
994400  1.90s Reloading;
002C99  2.08s Loading Resource - AssetLibrary;
2C9900  5.08s Preloading 53515 textures;
229900  1.78s Texture loading;
009911  5.76s Posting bake events;
00991C 32.40s Setting up dynamic models;
009926 32.48s Loading Resource - ModelManager;
00998C 33.26s Rendering Setup;
440099  1.46s XML Recipes;
4F0099  2.08s InterModComms;
990040 11.48s [VintageFix]: Texture search 70383 sprites;
990036  5.32s Preloaded 33922 sprites
`
    .split(';')
      .map(l => l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s))
      .forEach(([, col, time, name]) => {
        a.labels.push([
          name.length > 15 ? name.split(/(?%3C=.{11})\s(?=\S{6})/).join('\n') : name
          , ' ', time, 's'
        ].join(''));
        a.datasets[0].data.push(parseFloat(time));
        a.datasets[0].backgroundColor.push([String.fromCharCode(35), col].join(''))
      })
      ; return a
  })()}
}"/>
</p>
