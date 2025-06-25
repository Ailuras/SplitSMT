(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var253 0)
(declare-sort var1044 0)
(declare-sort var3136 0)
(declare-sort var2668 0)
(declare-sort var2509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2668_asList/1779083644 ((Array Int var2509)) var3136)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2509__ ((Array Int String)) (Array Int var2509))
(declare-fun var253-init () var253)
(declare-fun <init>/1236329532 (var253) void)
(declare-fun var3136_iterator/-912451715 (var3136) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var253 var253)
(declare-const null-String String)
(declare-const var1523 var253) ; Statement: r13 := @this: edu.stanford.nlp.international.morph.MorphoFeatures 
(assert (not (= var1523 null-var253)))
(declare-const var3760 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3760 null-String)))
; split operation: var3729 = var3760.split("\u005c-") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-") 
(define-const var3670 var3136 (var2668_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2509__ var3729))) ; Statement: r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(define-const var3937 var253 var253-init) ; Statement: $r3 = new edu.stanford.nlp.international.morph.MorphoFeatures 
(assert true)
;(assert (<init>/1236329532 var3937)) ; Statement: specialinvoke $r3.<edu.stanford.nlp.international.morph.MorphoFeatures: void <init>()>() 

(declare-const var3937!1 var253)
(define-const var2137 Iterator (var3136_iterator/-912451715 var3670)) ; Statement: r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2726 Bool (Iterator_hasNext/-1669924200 var2137)) ; Statement: $z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return $r3 
(assert (= (ite var2726 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r3 
(check-sat)
; {var2668_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2509__=([java.lang.String[]], java.lang.Object[]), var253-init=([], edu.stanford.nlp.international.morph.MorphoFeatures), <init>/1236329532=([edu.stanford.nlp.international.morph.MorphoFeatures], void), var3136_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var253=edu.stanford.nlp.international.morph.MorphoFeatures, var1523=r13, var3760=r0, var1044=null_type, var3729=$r1, var3136=java.util.List, var2668=java.util.Arrays, var2509=java.lang.Object, var3670=r2, var3937=$r3, var2137=r4, var2726=$z0}
; {edu.stanford.nlp.international.morph.MorphoFeatures=var253, r13=var1523, r0=var3760, null_type=var1044, $r1=var3729, java.util.List=var3136, java.util.Arrays=var2668, java.lang.Object=var2509, r2=var3670, $r3=var3937, r4=var2137, $z0=var2726}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r13 := @this: edu.stanford.nlp.international.morph.MorphoFeatures;	r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-");	r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	$r3 = new edu.stanford.nlp.international.morph.MorphoFeatures;	specialinvoke $r3.<edu.stanford.nlp.international.morph.MorphoFeatures: void <init>()>();	r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return $r3;	return $r3
;block_num 3