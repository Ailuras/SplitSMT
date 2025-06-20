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

(declare-sort var3870 0)
(declare-sort var2118 0)
(declare-sort var1995 0)
(declare-sort var3847 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1995-init () var1995)
(declare-fun <init>/1281898776 (var1995) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun iterator/-2009143821 (var2118) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var3870_put/1464166817 (var3870 var3847 var3847) var3847)
(declare-fun cast-from-String-to-var3847 (String) var3847)
(declare-fun cast-from-var1995-to-var3847 (var1995) var3847)
(declare-const null-String String)
(declare-const null-var3870 var3870)
(declare-const null-var2118 var2118)
(declare-const var2180 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2180 null-String)))
(declare-const var2861 var3870) ; Statement: r4 := @parameter1: java.util.Map 
(assert (not (= var2861 null-var3870)))
(declare-const var3912 var2118) ; Statement: r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var3912 null-var2118)))
(define-const var1924 var1995 var1995-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var1924)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var1924!1 var1995)
(assert true)
;(assert (append/672562846 var2180 "Valid Invokers: \n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n") 
(declare-const var2180!1 String)
(assert (= var2180!1 (str.++ var2180 "Valid Invokers: \n")))
(assert true)
(define-const var3835 Iterator (iterator/-2009143821 var3912)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2115 Bool (Iterator_hasNext/-1669924200 var3835)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var2115 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2180!1 "\n")) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var2180!2 String)
(assert (= var2180!2 (str.++ var2180!1 "\n")))
;(assert (var3870_put/1464166817 var2861 (cast-from-String-to-var3847 "Valid") (cast-from-var1995-to-var3847 var1924!1))) ; Statement: interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0) 

(declare-const var2861!1 var3870)
(declare-const var2781 String)
(declare-const var1924!2 var1995)
 ; Statement: return 
(check-sat)
; {var1995-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), iterator/-2009143821=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var3870_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3847=([java.lang.String], java.lang.Object), cast-from-var1995-to-var3847=([java.util.LinkedList], java.lang.Object)}
; {var2180=r1, var3870=java.util.Map, var2861=r4, var2118=org.apache.dubbo.rpc.cluster.router.state.BitList, var3912=r2, var1995=java.util.LinkedList, var1924=$r0, var3835=r3, var2115=$z0, var3847=java.lang.Object, var2781="Valid"}
; {r1=var2180, java.util.Map=var3870, r4=var2861, org.apache.dubbo.rpc.cluster.router.state.BitList=var2118, r2=var3912, java.util.LinkedList=var1995, $r0=var1924, r3=var3835, $z0=var2115, java.lang.Object=var3847, "Valid"=var2781}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r4 := @parameter1: java.util.Map;	r2 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Valid Invokers: \n");	r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	interfaceinvoke r4.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Valid", $r0);	return
;block_num 3