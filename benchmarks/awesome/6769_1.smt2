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

(declare-sort var572 0)
(declare-sort var1960 0)
(declare-sort var222 0)
(declare-sort var985 0)
(declare-sort var1398 0)
(declare-sort var1700 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var222_asList/1779083644 ((Array Int var985)) var1960)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var985__ ((Array Int String)) (Array Int var985))
(declare-fun var1700_getNgrams/489185624 (var1960 Int Int) var1398)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var794 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var794 null-String)))
(declare-const var1957 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1957 null-Int)))
(declare-const var3388 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3388 null-Int)))
; split operation: var351 = var794.split("\u005cs+") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3862 var1960 (var222_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var985__ var351))) ; Statement: $r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(define-const var1859 var1398 (var1700_getNgrams/489185624 var3862 var1957 var3388)) ; Statement: $r3 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Collection getNgrams(java.util.List,int,int)>($r2, i0, i1) 
 ; Statement: return $r3 
(check-sat)
; {var222_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var985__=([java.lang.String[]], java.lang.Object[]), var1700_getNgrams/489185624=([java.util.List, int, int], java.util.Collection)}
; {var794=r0, var572=null_type, var1957=i0, var3388=i1, var351=$r1, var1960=java.util.List, var222=java.util.Arrays, var985=java.lang.Object, var3862=$r2, var1398=java.util.Collection, var1700=edu.stanford.nlp.util.StringUtils, var1859=$r3}
; {r0=var794, null_type=var572, i0=var1957, i1=var3388, $r1=var351, java.util.List=var1960, java.util.Arrays=var222, java.lang.Object=var985, $r2=var3862, java.util.Collection=var1398, edu.stanford.nlp.util.StringUtils=var1700, $r3=var1859}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<edu.stanford.nlp.util.StringUtils: java.util.Collection getNgrams(java.util.List,int,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<edu.stanford.nlp.util.StringUtils: java.util.Collection getNgrams(java.util.List,int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	i1 := @parameter2: int;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	$r3 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Collection getNgrams(java.util.List,int,int)>($r2, i0, i1);	return $r3
;block_num 1