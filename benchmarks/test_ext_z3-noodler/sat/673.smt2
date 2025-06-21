(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1231 0)
(declare-sort var2643 0)
(declare-sort var2361 0)
(declare-sort var2756 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2643_sort/-2094180924 ((Array Int var2361)) void)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2361__ ((Array Int String)) (Array Int var2361))
(declare-fun var2643_asList/1779083644 ((Array Int var2361)) var2756)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2756_iterator/-912451715 (var2756) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3812 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3812 null-String)))
; split operation: var3161 = var3812.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
;(assert (var2643_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var2361__ var3161))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1) 

(declare-const var3161!1 (Array Int String))
(define-const var673 var2756 (var2643_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2361__ var3161!1))) ; Statement: r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1) 
(define-const var1510 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1510)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1510!1 String)
(assert (= var1510!1 ""))
(define-const var605 Iterator (var2756_iterator/-912451715 var673)) ; Statement: r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var941 Bool (Iterator_hasNext/-1669924200 var605)) ; Statement: $z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var941 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3 String (toString/-2075883882 var1510!1)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {var2643_sort/-2094180924=([java.lang.Object[]], void), cast-from-__Array__Int__String__-to-__Array__Int__var2361__=([java.lang.String[]], java.lang.Object[]), var2643_asList/1779083644=([java.lang.Object[]], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2756_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3812=r0, var1231=null_type, var3161=r1, var2643=java.util.Arrays, var2361=java.lang.Object, var2756=java.util.List, var673=r2, var1510=$r3, var605=r4, var941=$z0, var3=$r5}
; {r0=var3812, null_type=var1231, r1=var3161, java.util.Arrays=var2643, java.lang.Object=var2361, java.util.List=var2756, r2=var673, $r3=var1510, r4=var605, $z0=var941, $r5=var3}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r1);	r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r1);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	r4 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r4.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 3