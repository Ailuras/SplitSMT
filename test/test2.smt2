(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(declare-sort var1815 0)
(declare-sort var1976 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1815 var1815)
(declare-const null-String String)
(declare-const var856 var1815) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var856 null-var1815)))
(declare-const var3010 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3010 null-String)))
(define-const var1498 Int var2118) ; Statement: $i0 = lengthof $r1 
(define-const var2118 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var3020 = var3010.split(":", var2118) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (= var1498 4))) ; Cond: $i0 != 4 
(define-const var3279 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
