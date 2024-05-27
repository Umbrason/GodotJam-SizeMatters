class_name FloatSpring

var Position : float = 0
var Velocity : float = 0
var RestingPos : float = 0

var AngularFrequency : float = 20.0
var DampingRatio : float = .6

func _init(_AngularFrequency, _DampingRatio):
	AngularFrequency = _AngularFrequency
	DampingRatio = _DampingRatio

func step(deltaTime):
	if (AngularFrequency <= 0): return
	var oldPos = Position - RestingPos
	var oldVel = Velocity

	if (DampingRatio < 0.0): DampingRatio = 0.0
	if (AngularFrequency < 0.0): AngularFrequency = 0.0
	
	if (DampingRatio > 1.0):
		var za = -AngularFrequency * DampingRatio
		var zb = AngularFrequency * sqrt(DampingRatio * DampingRatio - 1.0)
		var z1 = za - zb
		var z2 = za + zb

		var e1 = exp(z1 * deltaTime)
		var e2 = exp(z2 * deltaTime)

		var invTwoZb = 1.0 / (2.0 * zb)

		var e1OverTwoZb = e1 * invTwoZb
		var e2OverTwoZb = e2 * invTwoZb

		var z1e1OverTwoZb = z1 * e1OverTwoZb
		var z2e2OverTwoZb = z2 * e2OverTwoZb

		Position = oldPos * (e1OverTwoZb * z2 - z2e2OverTwoZb + e2) + oldVel * (-e1OverTwoZb + e2OverTwoZb) + RestingPos
		Velocity = oldPos * ((z1e1OverTwoZb - z2e2OverTwoZb + e2) * z2) + oldVel * (-z1e1OverTwoZb + z2e2OverTwoZb)			
		return		
	if (DampingRatio < 1.0):
		var omegaZeta = AngularFrequency * DampingRatio
		var alpha = AngularFrequency * sqrt(1.0 - DampingRatio * DampingRatio)

		var expTerm = exp(-omegaZeta * deltaTime)
		var cosTerm = cos(alpha * deltaTime)
		var sinTerm = sin(alpha * deltaTime)

		var invAlpha = 1.0 / alpha

		var expSin = expTerm * sinTerm
		var expCos = expTerm * cosTerm
		var expOmegaZetaSinOverAlpha = expTerm * omegaZeta * sinTerm * invAlpha

		Position = oldPos * (expCos + expOmegaZetaSinOverAlpha) + oldVel * (expSin * invAlpha) + RestingPos
		Velocity = oldPos * (-expSin * alpha - omegaZeta * expOmegaZetaSinOverAlpha) + oldVel * (expCos - expOmegaZetaSinOverAlpha)			
		return

	if true:
		var expTerm = exp(-AngularFrequency * deltaTime)
		var timeExp = deltaTime * expTerm
		var timeExpFreq = timeExp * AngularFrequency
		Position = oldPos * (timeExpFreq + expTerm) + oldVel * timeExp + RestingPos
		Velocity = oldPos * (-AngularFrequency * timeExpFreq) + oldVel * (-timeExpFreq + expTerm)
