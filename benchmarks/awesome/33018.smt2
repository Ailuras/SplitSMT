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

(declare-sort var2930 0)
(declare-sort var3483 0)
(declare-sort var2463 0)
(declare-sort var3265 0)
(declare-sort var3285 0)
(declare-sort var2849 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2463-init () var2463)
(declare-fun <init>/-325640736 (var2463) void)
(declare-fun var3285_asList/1779083644 ((Array Int var2849)) var3265)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2849__ ((Array Int String)) (Array Int var2849))
(declare-fun arr-String-init () (Array Int String))
(declare-fun var3265_size/-959786421 (var3265) Int)
(declare-const null-var2930 var2930)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var351 var2930) ; Statement: r24 := @this: edu.stanford.nlp.process.stattok.StatTokSent 
(assert (not (= var351 null-var2930)))
(declare-const var756 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var756 null-String)))
(declare-const var1441 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1441 null-Int)))
(define-const var1506 var2463 var2463-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1506)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1506!1 var2463)
; split operation: var1207 = var756.split("") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("") 
(define-const var2620 var3265 (var3285_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2849__ var1207))) ; Statement: r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r2) 
(define-const var2236 Int (* var1441 2)) ; Statement: $i1 = i0 * 2 
(define-const var3746 Int (+ var2236 1)) ; Statement: $i2 = $i1 + 1 
(define-const var3155 (Array Int String) arr-String-init) ; Statement: r4 = newarray (java.lang.String)[$i2] 
(define-const var2649 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
(define-const var3654 Int (var3265_size/-959786421 var2620)) ; Statement: $i3 = interfaceinvoke r3.<java.util.List: int size()>() 
 ; Statement: if i9 >= $i3 goto return $r0 
(assert (>= var2649 var3654)) ; Cond: i9 >= $i3 
 ; Statement: return $r0 
(check-sat)
; {var2463-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var3285_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2849__=([java.lang.String[]], java.lang.Object[]), arr-String-init=([], java.lang.String[]), var3265_size/-959786421=([java.util.List], int)}
; {var2930=edu.stanford.nlp.process.stattok.StatTokSent, var351=r24, var756=r1, var3483=null_type, var1441=i0, var2463=java.util.ArrayList, var1506=$r0, var1207=r2, var3265=java.util.List, var3285=java.util.Arrays, var2849=java.lang.Object, var2620=r3, var2236=$i1, var3746=$i2, var3155=r4, var2649=i9, var3654=$i3}
; {edu.stanford.nlp.process.stattok.StatTokSent=var2930, r24=var351, r1=var756, null_type=var3483, i0=var1441, java.util.ArrayList=var2463, $r0=var1506, r2=var1207, java.util.List=var3265, java.util.Arrays=var3285, java.lang.Object=var2849, r3=var2620, $i1=var2236, $i2=var3746, r4=var3155, i9=var2649, $i3=var3654}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r24 := @this: edu.stanford.nlp.process.stattok.StatTokSent;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("");	r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r2);	$i1 = i0 * 2;	$i2 = $i1 + 1;	r4 = newarray (java.lang.String)[$i2];	i9 = 0;	$i3 = interfaceinvoke r3.<java.util.List: int size()>();	if i9 >= $i3 goto return $r0;	return $r0
;block_num 3