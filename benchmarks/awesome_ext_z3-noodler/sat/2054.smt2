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

(declare-sort var3154 0)
(declare-sort var3324 0)
(declare-sort var1083 0)
(declare-sort var3882 0)
(declare-sort var1988 0)
(declare-sort var2405 0)
(declare-sort var653 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProperty/-469436802 (var3154 String String) String)
(declare-fun var1083_asList/1779083644 ((Array Int var3882)) var3324)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3882__ ((Array Int String)) (Array Int var3882))
(declare-fun var2405_newHashSet/-438716120 (var653) var1988)
(declare-fun cast-from-var3324-to-var653 (var3324) var653)
(declare-fun var1988_contains/1636690605 (var1988 var3882) Bool)
(declare-fun cast-from-String-to-var3882 (String) var3882)
(declare-const null-var3154 var3154)
(declare-const var147 var3154) ; Statement: r0 := @parameter0: java.util.Properties 
(assert (not (= var147 null-var3154)))
(assert true)
(define-const var3049 String (getProperty/-469436802 var147 "annotators" "")) ; Statement: $r1 = virtualinvoke r0.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("annotators", "") 
; split operation: var693 = var3049.split("[, \t]+") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[, \t]+") 
(define-const var1068 var3324 (var1083_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3882__ var693))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r2) 
(define-const var1016 var1988 (var2405_newHashSet/-438716120 (cast-from-var3324-to-var653 var1068))) ; Statement: r4 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r3) 
(define-const var2849 Bool (var1988_contains/1636690605 var1016 (cast-from-String-to-var3882 "sentiment"))) ; Statement: $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>("sentiment") 
 ; Statement: return $z0 
(check-sat)
; {getProperty/-469436802=([java.util.Properties, java.lang.String, java.lang.String], java.lang.String), var1083_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3882__=([java.lang.String[]], java.lang.Object[]), var2405_newHashSet/-438716120=([java.util.Collection], java.util.Set), cast-from-var3324-to-var653=([java.util.List], java.util.Collection), var1988_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var3882=([java.lang.String], java.lang.Object)}
; {var3154=java.util.Properties, var147=r0, var3049=$r1, var693=$r2, var3324=java.util.List, var1083=java.util.Arrays, var3882=java.lang.Object, var1068=$r3, var1988=java.util.Set, var2405=edu.stanford.nlp.util.Generics, var653=java.util.Collection, var1016=r4, var2849=$z0}
; {java.util.Properties=var3154, r0=var147, $r1=var3049, $r2=var693, java.util.List=var3324, java.util.Arrays=var1083, java.lang.Object=var3882, $r3=var1068, java.util.Set=var1988, edu.stanford.nlp.util.Generics=var2405, java.util.Collection=var653, r4=var1016, $z0=var2849}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Properties;	$r1 = virtualinvoke r0.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("annotators", "");	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[, \t]+");	$r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r2);	r4 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r3);	$z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>("sentiment");	return $z0
;block_num 1