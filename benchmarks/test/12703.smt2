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

(declare-sort var1720 0)
(declare-sort var2914 0)
(declare-sort var3226 0)
(declare-sort var3909 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3226-init () var3226)
(declare-fun <init>/1281898776 (var3226) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2914_iterator/1911472585 (var2914) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var1720_put/1464166817 (var1720 var3909 var3909) var3909)
(declare-fun cast-from-String-to-var3909 (String) var3909)
(declare-fun cast-from-var3226-to-var3909 (var3226) var3909)
(declare-const null-String String)
(declare-const null-var1720 var1720)
(declare-const null-var2914 var2914)
(declare-const var1902 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1902 null-String)))
(declare-const var1812 var1720) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var1812 null-var1720)))
(declare-const var3698 var2914) ; Statement: r2 := @parameter2: java.util.Set 
(assert (not (= var3698 null-var2914)))
(define-const var544 var3226 var3226-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var544)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var544!1 var3226)
(assert true)
;(assert (append/672562846 var1902 "Disabled Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Disabled Invokers: \n") 
(declare-const var1902!1 String)
(assert (= var1902!1 (str.++ var1902 "Disabled Invokers: \n")))
(define-const var397 Iterator (var2914_iterator/1911472585 var3698)) ; Statement: r3 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var663 Bool (Iterator_hasNext/-1669924200 var397)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var663 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1902!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1902!2 String)
(assert (= var1902!2 (str.++ var1902!1 "\n")))
;(assert (var1720_put/1464166817 var1812 (cast-from-String-to-var3909 "Disabled") (cast-from-var3226-to-var3909 var544!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Disabled", $r0) 

(declare-const var1812!1 var1720)
(declare-const var740 String)
(declare-const var544!2 var3226)
 ; Statement: return 
(check-sat)
; {var3226-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2914_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var1720_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3909=([java.lang.String], java.lang.Object), cast-from-var3226-to-var3909=([java.util.LinkedList], java.lang.Object)}
; {var1902=r1, var1720=java.util.Map, var1812=r4, var2914=java.util.Set, var3698=r2, var3226=java.util.LinkedList, var544=$r0, var397=r3, var663=$z0, var3909=java.lang.Object, var740="Disabled"}
; {r1=var1902, java.util.Map=var1720, r4=var1812, java.util.Set=var2914, r2=var3698, java.util.LinkedList=var3226, $r0=var544, r3=var397, $z0=var663, java.lang.Object=var3909, "Disabled"=var740}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: java.util.Set;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Disabled Invokers: \n");	r3 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Disabled", $r0);	return
;block_num 3