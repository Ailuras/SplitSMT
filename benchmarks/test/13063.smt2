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

(declare-sort var2479 0)
(declare-sort var1570 0)
(declare-sort var1669 0)
(declare-sort var3185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1669-init () var1669)
(declare-fun <init>/1281898776 (var1669) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun iterator/-2009143821 (var1570) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var2479_put/1464166817 (var2479 var3185 var3185) var3185)
(declare-fun cast-from-String-to-var3185 (String) var3185)
(declare-fun cast-from-var1669-to-var3185 (var1669) var3185)
(declare-const null-String String)
(declare-const null-var2479 var2479)
(declare-const null-var1570 var1570)
(declare-const var3767 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3767 null-String)))
(declare-const var307 var2479) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var307 null-var2479)))
(declare-const var1495 var1570) ; Statement: r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var1495 null-var1570)))
(define-const var1681 var1669 var1669-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var1681)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var1681!1 var1669)
(assert true)
;(assert (append/672562846 var3767 "Valid Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n") 
(declare-const var3767!1 String)
(assert (= var3767!1 (str.++ var3767 "Valid Invokers: \n")))
(assert true)
(define-const var90 Iterator (iterator/-2009143821 var1495)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1482 Bool (Iterator_hasNext/-1669924200 var90)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var1482 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var3767!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var3767!2 String)
(assert (= var3767!2 (str.++ var3767!1 "\n")))
;(assert (var2479_put/1464166817 var307 (cast-from-String-to-var3185 "Valid") (cast-from-var1669-to-var3185 var1681!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0) 

(declare-const var307!1 var2479)
(declare-const var2628 String)
(declare-const var1681!2 var1669)
 ; Statement: return 
(check-sat)
; {var1669-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), iterator/-2009143821=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var2479_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3185=([java.lang.String], java.lang.Object), cast-from-var1669-to-var3185=([java.util.LinkedList], java.lang.Object)}
; {var3767=r1, var2479=java.util.Map, var307=r4, var1570=org.apache.dubbo.rpc.cluster.router.state.BitList, var1495=r2, var1669=java.util.LinkedList, var1681=$r0, var90=r3, var1482=$z0, var3185=java.lang.Object, var2628="Valid"}
; {r1=var3767, java.util.Map=var2479, r4=var307, org.apache.dubbo.rpc.cluster.router.state.BitList=var1570, r2=var1495, java.util.LinkedList=var1669, $r0=var1681, r3=var90, $z0=var1482, java.lang.Object=var3185, "Valid"=var2628}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n");	r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0);	return
;block_num 3