# this card was used to produce the Run 2 UL sample PPD-RunIISummer20UL18GEN-00020
import FWCore.ParameterSet.Config as cms

from Configuration.Generator.Herwig7Settings.Herwig7StableParticlesForDetector_cfi import *
from Configuration.Generator.Herwig7Settings.Herwig7CH3TuneSettings_cfi import *

generator = cms.EDFilter("Herwig7GeneratorFilter",
    herwig7StableParticlesForDetectorBlock,
    herwig7CH3SettingsBlock,
    run = cms.string('InterfaceMatchboxTest'),
    dumpConfig = cms.untracked.string('HerwigConfig.in'),
    repository = cms.string('${HERWIGPATH}/HerwigDefaults.rpo'),
    dataLocation = cms.string('${HERWIGPATH:-6}'),
    generatorModule = cms.string('/Herwig/Generators/EventGenerator'),
    eventHandlers = cms.string('/Herwig/EventHandlers'),
    configFiles = cms.vstring(),
    crossSection = cms.untracked.double(-1),
    filterEfficiency = cms.untracked.double(1.0),
    Matchbox = cms.vstring( 'read snippets/Matchbox.in',
    'read snippets/PPCollider.in',
    'cd /Herwig/EventHandlers',
    'set EventHandler:LuminosityFunction:Energy 13000*GeV',
    '## Model assumptions',
    'read Matchbox/StandardModelLike.in',
    'read Matchbox/DiagonalCKM.in',
    '## Set the order of the couplings',
    'cd /Herwig/MatrixElements/Matchbox',
    'set Factory:OrderInAlphaS 0',
    'set Factory:OrderInAlphaEW 2',
    '## Define l = e, mu, tau',
    'do Factory:StartParticleGroup l+',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/e+',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/mu+',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/tau+',
    'do Factory:EndParticleGroup',
    'do Factory:StartParticleGroup l-',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/e-',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/mu-',
    'insert Factory:ParticleGroup 0 /Herwig/Particles/tau-',
    'do Factory:EndParticleGroup',
    '## Select the process',
    'do Factory:Process p p -> l+ l-',
    '# read Matchbox/MadGraph-GoSam.in',
    '# read Matchbox/MadGraph-MadGraph.in',
    'read Matchbox/MadGraph-OpenLoops.in',
    'set /Herwig/Cuts/ChargedLeptonPairMassCut:MinMass 50*GeV',
    'set /Herwig/Cuts/ChargedLeptonPairMassCut:MaxMass 14000*GeV',
    'cd /Herwig/MatrixElements/Matchbox',
    'set Factory:ScaleChoice /Herwig/MatrixElements/Matchbox/Scales/LeptonPairMassScale',
    'read Matchbox/MCatNLO-DefaultShower.in',
    '# read Matchbox/NLO-NoShower.in',
    '# read Matchbox/LO-NoShower.in',
    'read Matchbox/FiveFlavourScheme.in',
    'do /Herwig/MatrixElements/Matchbox/Factory:ProductionMode',
    ),
    parameterSets = cms.vstring('herwig7StableParticlesForDetector', 'Matchbox','herwig7CH3PDF', 'herwig7CH3AlphaS','herwig7CH3MPISettings'),
)

ProductionFilterSequence = cms.Sequence(generator)
