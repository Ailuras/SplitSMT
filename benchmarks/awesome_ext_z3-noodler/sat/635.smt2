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

(declare-sort var1867 0)
(declare-sort var3739 0)
(declare-sort var921 0)
(declare-sort var1896 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3739_sort/-2094180924 ((Array Int var921)) void)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var921__ ((Array Int String)) (Array Int var921))
(declare-fun var3739_asList/1779083644 ((Array Int var921)) var1896)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1896_iterator/-912451715 (var1896) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2178 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2178 null-String)))
; split operation: var2723 = var2178.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
;(assert (var3739_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var921__ var2723))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1) 

(declare-const var2723!1 (Array Int String))
(define-const var1322 var1896 (var3739_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var921__ var2723!1))) ; Statement: r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1) 
(define-const var877 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var877)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var877!1 String)
(assert (= var877!1 ""))
(define-const var3442 Iterator (var1896_iterator/-912451715 var1322)) ; Statement: r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2092 Bool (Iterator_hasNext/-1669924200 var3442)) ; Statement: $z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2092 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var649 String (toString/-2075883882 var877!1)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {var3739_sort/-2094180924=([java.lang.Object[]], void), cast-from-__Array__Int__String__-to-__Array__Int__var921__=([java.lang.String[]], java.lang.Object[]), var3739_asList/1779083644=([java.lang.Object[]], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1896_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2178=r0, var1867=null_type, var2723=r1, var3739=java.util.Arrays, var921=java.lang.Object, var1896=java.util.List, var1322=r2, var877=$r3, var3442=r4, var2092=$z0, var649=$r5}
; {r0=var2178, null_type=var1867, r1=var2723, java.util.Arrays=var3739, java.lang.Object=var921, java.util.List=var1896, r2=var1322, $r3=var877, r4=var3442, $z0=var2092, $r5=var649}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1);	r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 3