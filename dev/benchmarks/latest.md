## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
342 sec
<br>
<sup><sub>(
5:42 min
)</sub></sup>
</p>

<br>
<!--
Note for image scripts:
  - Newlines are ignored
  - This characters cant be used: +<"%#
-->
<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [51.00]},
        {label: 'Construction\n', data: [48.00]},
        {label: 'PreInit\n', data: [183.00]},
        {label: 'Init\n', data: [57.00]},
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
          value: 51,
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
<img src="https://quickchart.io/chart.png?w=400&h=300&c={
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
436e17  7.79s Had Enough Items;
395E14  1.02s [JEI Ingredient Filter];
395E14 11.48s [JEI Plugins];
5161a8  6.80s CraftTweaker2;
516fa8  5.52s Ender IO;
8f304e  5.14s Astral Sorcery;
a651a8  4.47s IndustrialCraft 2;
cd922c  3.58s NuclearCraft;
6e5e17  3.48s Tinkers' Antique;
5E5014  2.00s [TCon Textures];
813e81  3.10s OpenComputers;
6e175e  3.06s Recurrent Complex;
213664  2.97s Forestry;
308f7e  2.36s Quark: RotN Edition;
ba3eb8  2.10s Cyclic;
3e7d81  2.10s ProbeZS;
306e8f  1.95s Custom Loading Screen;
216364  1.93s Thermal Expansion;
436e17  1.92s Integrated Dynamics;
444444 25.58s 18 Other mods;
333333 44.78s 141 'Fast' mods (1.0s - 0.1s);
222222  7.96s 304 'Instant' mods (%3C 0.1s)
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
<img src="https://quickchart.io/chart.png?w=400&h=450&c={
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
CraftTweaker2                 | 0.09| 0.00| 2.35| 4.26| 0.00| 0.10| 0.00| 0.00;
Ender IO                      | 1.25| 0.01| 2.52| 0.29| 1.45| 0.00| 0.01| 0.00;
Astral Sorcery                | 0.16| 0.00| 4.01| 0.96| 0.00| 0.00| 0.00| 0.00;
IndustrialCraft 2             | 0.57| 0.01| 3.16| 0.73| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.05| 0.01| 2.48| 1.01| 0.00| 0.00| 0.03| 0.00;
Tinkers' Antique              | 0.69| 0.01| 0.10| 0.68| 0.00| 0.00| 0.00| 2.00;
OpenComputers                 | 0.14| 0.01| 1.27| 1.64| 0.04| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.18| 0.00| 0.25| 2.62| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.26| 0.01| 2.02| 0.69| 0.00| 0.00| 0.00| 0.00;
Quark: RotN Edition           | 0.02| 0.01| 2.23| 0.10| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.14| 0.07| 0.00| 0.01| 0.00| 0.00
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
<img src="https://quickchart.io/chart.png?w=500&h=200&c={
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
 3.23: com._0xc4de.ae2exttable.integration.JEIPlugin;
 1.48: jeresources.jei.JEIConfig;
 1.42: li.cil.oc.integration.jei.ModPluginOpenComputers;
 0.66: com.buuz135.industrial.jei.JEICustomPlugin;
 0.62: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.45: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.44: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.40: ic2.jeiIntegration.SubModule;
 0.31: rustic.compat.jei.RusticJEIPlugin;
 0.17: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.16: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.16: crazypants.enderio.base.integration.jei.JeiPlugin;
 1.97: Other
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
<img src="https://quickchart.io/chart.png?w=500&h=400&c={
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
            text: '190.99s',
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
994400  1.37s Reloading;
002299  2.28s Loading Resource - AssetLibrary;
229900  4.20s Posting bake events;
179900 94.22s Setting up dynamic models;
0D9900 94.29s Loading Resource - ModelManager;
009959 95.01s Rendering Setup;
1C0099  1.40s XML Recipes;
260099  1.87s InterModComms;
990069 12.40s [VintageFix]: Texture search 69381 sprites
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
