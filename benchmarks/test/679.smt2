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

(declare-sort var3929 0)
(declare-sort var291 0)
(declare-sort var1600 0)
(declare-sort var3960 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var291_sort/-2094180924 ((Array Int var1600)) void)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1600__ ((Array Int String)) (Array Int var1600))
(declare-fun var291_asList/1779083644 ((Array Int var1600)) var3960)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3960_iterator/-912451715 (var3960) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2869 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2869 null-String)))
; split operation: var3046 = var2869.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
;(assert (var291_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var1600__ var3046))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1) 

(declare-const var3046!1 (Array Int String))
(define-const var773 var3960 (var291_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var1600__ var3046!1))) ; Statement: r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1) 
(define-const var943 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var943)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var943!1 String)
(assert (= var943!1 ""))
(define-const var3009 Iterator (var3960_iterator/-912451715 var773)) ; Statement: r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var86 Bool (Iterator_hasNext/-1669924200 var3009)) ; Statement: $z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var86 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var347 String (toString/-2075883882 var943!1)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {var291_sort/-2094180924=([java.lang.Object[]], void), cast-from-__Array__Int__String__-to-__Array__Int__var1600__=([java.lang.String[]], java.lang.Object[]), var291_asList/1779083644=([java.lang.Object[]], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3960_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2869=r0, var3929=null_type, var3046=r1, var291=java.util.Arrays, var1600=java.lang.Object, var3960=java.util.List, var773=r2, var943=$r3, var3009=r4, var86=$z0, var347=$r5}
; {r0=var2869, null_type=var3929, r1=var3046, java.util.Arrays=var291, java.lang.Object=var1600, java.util.List=var3960, r2=var773, $r3=var943, r4=var3009, $z0=var86, $r5=var347}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1);	r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 3