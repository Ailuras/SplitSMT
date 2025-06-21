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

(declare-sort var2399 0)
(declare-sort var3607 0)
(declare-sort var3356 0)
(declare-sort var676 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3356-init () var3356)
(declare-fun <init>/1281898776 (var3356) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3607_iterator/1911472585 (var3607) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var2399_put/1464166817 (var2399 var676 var676) var676)
(declare-fun cast-from-String-to-var676 (String) var676)
(declare-fun cast-from-var3356-to-var676 (var3356) var676)
(declare-const null-String String)
(declare-const null-var2399 var2399)
(declare-const null-var3607 var3607)
(declare-const var3406 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3406 null-String)))
(declare-const var2154 var2399) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var2154 null-var2399)))
(declare-const var3454 var3607) ; Statement: r2 := @parameter2: java.util.Set 
(assert (not (= var3454 null-var3607)))
(define-const var3452 var3356 var3356-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var3452)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var3452!1 var3356)
(assert true)
;(assert (append/672562846 var3406 "Disabled Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Disabled Invokers: \n") 
(declare-const var3406!1 String)
(assert (= var3406!1 (str.++ var3406 "Disabled Invokers: \n")))
(define-const var619 Iterator (var3607_iterator/1911472585 var3454)) ; Statement: r3 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2100 Bool (Iterator_hasNext/-1669924200 var619)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var2100 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var3406!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var3406!2 String)
(assert (= var3406!2 (str.++ var3406!1 "\n")))
;(assert (var2399_put/1464166817 var2154 (cast-from-String-to-var676 "Disabled") (cast-from-var3356-to-var676 var3452!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Disabled", $r0) 

(declare-const var2154!1 var2399)
(declare-const var1711 String)
(declare-const var3452!2 var3356)
 ; Statement: return 
(check-sat)
; {var3356-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3607_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var2399_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var676=([java.lang.String], java.lang.Object), cast-from-var3356-to-var676=([java.util.LinkedList], java.lang.Object)}
; {var3406=r1, var2399=java.util.Map, var2154=r4, var3607=java.util.Set, var3454=r2, var3356=java.util.LinkedList, var3452=$r0, var619=r3, var2100=$z0, var676=java.lang.Object, var1711="Disabled"}
; {r1=var3406, java.util.Map=var2399, r4=var2154, java.util.Set=var3607, r2=var3454, java.util.LinkedList=var3356, $r0=var3452, r3=var619, $z0=var2100, java.lang.Object=var676, "Disabled"=var1711}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: java.util.Set;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Disabled Invokers: \n");	r3 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Disabled", $r0);	return
;block_num 3