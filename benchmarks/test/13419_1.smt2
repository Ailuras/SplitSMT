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

(declare-sort var2182 0)
(declare-sort var2282 0)
(declare-sort var1438 0)
(declare-sort var807 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1438-init () var1438)
(declare-fun <init>/1281898776 (var1438) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2282_iterator/-912451715 (var2282) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var2182_put/1464166817 (var2182 var807 var807) var807)
(declare-fun cast-from-String-to-var807 (String) var807)
(declare-fun cast-from-var1438-to-var807 (var1438) var807)
(declare-const null-String String)
(declare-const null-var2182 var2182)
(declare-const null-var2282 var2282)
(declare-const var1827 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1827 null-String)))
(declare-const var1394 var2182) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var1394 null-var2182)))
(declare-const var793 var2282) ; Statement: r2 := @parameter2: java.util.List 
(assert (not (= var793 null-var2282)))
(define-const var3931 var1438 var1438-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var3931)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var3931!1 var1438)
(assert true)
;(assert (append/672562846 var1827 "All Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("All Invokers: \n") 
(declare-const var1827!1 String)
(assert (= var1827!1 (str.++ var1827 "All Invokers: \n")))
(define-const var872 Iterator (var2282_iterator/-912451715 var793)) ; Statement: r3 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2338 Bool (Iterator_hasNext/-1669924200 var872)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var2338 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1827!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1827!2 String)
(assert (= var1827!2 (str.++ var1827!1 "\n")))
;(assert (var2182_put/1464166817 var1394 (cast-from-String-to-var807 "All") (cast-from-var1438-to-var807 var3931!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("All", $r0) 

(declare-const var1394!1 var2182)
(declare-const var1794 String)
(declare-const var3931!2 var1438)
 ; Statement: return 
(check-sat)
; {var1438-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2282_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var2182_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var807=([java.lang.String], java.lang.Object), cast-from-var1438-to-var807=([java.util.LinkedList], java.lang.Object)}
; {var1827=r1, var2182=java.util.Map, var1394=r4, var2282=java.util.List, var793=r2, var1438=java.util.LinkedList, var3931=$r0, var872=r3, var2338=$z0, var807=java.lang.Object, var1794="All"}
; {r1=var1827, java.util.Map=var2182, r4=var1394, java.util.List=var2282, r2=var793, java.util.LinkedList=var1438, $r0=var3931, r3=var872, $z0=var2338, java.lang.Object=var807, "All"=var1794}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: java.util.List;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("All Invokers: \n");	r3 = interfaceinvoke r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("All", $r0);	return
;block_num 3