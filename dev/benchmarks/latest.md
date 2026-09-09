## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
289 sec
<br>
<sup><sub>(
4:49 min
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
        {label: 'Mixins\n', data: [45.00]},
        {label: 'Construction\n', data: [49.00]},
        {label: 'PreInit\n', data: [131.00]},
        {label: 'Init\n', data: [59.00]},
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
          value: 45,
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
436e17 13.26s Had Enough Items;
395E14  6.38s [JEI Plugins];
5161a8  7.47s CraftTweaker2;
6a3eba  5.98s Ender IO CEu;
5A359E  1.06s [VF ModelBake];
8f304e  5.88s Astral Sorcery;
213664  4.85s Forestry;
1C2E55  1.29s [VF ModelBake];
a651a8  4.78s IndustrialCraft 2;
cd922c  4.28s NuclearCraft;
813e81  3.81s OpenComputers;
176e6e  3.43s Recurrent Complex Volts;
3e68ba  3.20s AE2 Unofficial Extended Life;
35589E  0.86s [VF ModelBake];
308f7e  2.57s Quark: RotN Edition;
216364  2.44s Thermal Expansion;
306e8f  2.36s Custom Loading Screen;
8c2ccd  2.34s Immersive Engineering;
a86e51  2.35s Extra Utilities 2;
3e8160  2.23s The Twilight Forest;
444444 43.56s 29 Other mods;
333333 50.03s 159 'Fast' mods (1.0s - 0.1s);
222222  8.44s 301 'Instant' mods (%3C 0.1s)
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
CraftTweaker2                 | 0.16| 0.00| 3.21| 4.06| 0.00| 0.04| 0.00| 0.00;
Ender IO CEu                  | 0.93| 0.01| 2.34| 0.20| 1.36| 0.00| 0.08| 1.06;
Astral Sorcery                | 0.16| 0.00| 4.79| 0.93| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.38| 0.01| 2.26| 0.91| 0.00| 0.00| 0.00| 1.29;
IndustrialCraft 2             | 0.95| 0.01| 3.13| 0.70| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.05| 0.01| 3.18| 0.97| 0.00| 0.00| 0.07| 0.00;
OpenComputers                 | 0.17| 0.01| 1.32| 1.51| 0.10| 0.00| 0.00| 0.36;
Recurrent Complex Volts       | 0.18| 0.00| 0.38| 2.88| 0.00| 0.00| 0.00| 0.00;
AE2 Unofficial Extended Life  | 0.08| 0.01| 1.62| 0.62| 0.01| 0.00| 0.00| 0.86;
Quark: RotN Edition           | 0.06| 0.01| 2.39| 0.12| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.07| 0.00| 0.16| 0.08| 0.00| 0.01| 0.00| 0.01
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
 0.86: jeresources.jei.JEIConfig;
 0.61: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.59: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.58: com.buuz135.industrial.jei.JEICustomPlugin;
 0.42: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.37: ic2.jeiIntegration.SubModule;
 0.23: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.22: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.21: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.17: roidrole.thaumicinfo.HEIPlugin;
 0.14: ninjabrain.gendustryjei.GendustryJEIPlugin;
 0.11: net.bdew.jeibees.BeesJEIPlugin;
 1.89: Other
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
            text: '106.63s',
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
994400  1.76s Reloading;
002C99  2.99s Loading Resource - AssetLibrary;
2C9900  4.79s Preloading 53522 textures;
229900  1.75s Texture loading;
009911  6.03s Posting bake events;
00991C 20.09s Setting up dynamic models;
009926 20.16s Loading Resource - ModelManager;
00998C 21.10s Rendering Setup;
440099  1.33s XML Recipes;
4F0099  1.93s InterModComms;
007399  3.58s [VintageFix]: Texture search 71034 sprites;
006999  4.89s Preloaded 33928 sprites;
444444  9.81s Other
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
