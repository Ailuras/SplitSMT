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
(declare-sort var1326 0)
(declare-sort var3871 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun doNotify/100853974 (var1720 String var3871) void)
(declare-fun delayTime/1655264999 (var1720) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1720 var1720)
(declare-const null-String String)
(declare-const null-var3871 var3871)
(declare-const var1507 var1720) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier 
(assert (not (= var1507 null-var1720)))
(declare-const var3311 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3311 null-String)))
(declare-const var2584 var3871) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var2584 null-var3871)))
(assert true)
(define-const var1946 Bool (endsWith/985337093 var3311 "configurators")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("configurators") 
 ; Statement: if $z0 != 0 goto virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2) 
(assert (not (= (ite var1946 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (doNotify/100853974 var1507 var3311 var2584)) ; Statement: virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2) 

(declare-const var1507!1 var1720)
(declare-const var3311!1 String)
(declare-const var2584!1 var3871)
(assert true) ; Non Conditional
(define-const var1887 Int (delayTime/1655264999 var1507!1)) ; Statement: $l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime> 
(define-const var3350 Int (ite (> var1887 0) 1 (ite (< var1887 0) -1 0))) ; Statement: $b7 = $l6 cmp 0L 
(define-const var2448 Int (cast-from-Int-to-Int var3350)) ; Statement: $i9 = (int) $b7 
 ; Statement: if $i9 > 0 goto $l0 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime> 
(assert (not (> var2448 0))) ; Negate: Cond: $i9 > 0  
(assert true)
;(assert (doNotify/100853974 var1507!1 var3311!1 var2584!1)) ; Statement: virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2) 

(declare-const var1507!2 var1720)
(declare-const var3311!2 String)
(declare-const var2584!2 var3871)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), doNotify/100853974=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier, java.lang.String, java.lang.Object], void), delayTime/1655264999=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier], long), cast-from-Int-to-Int=([byte], int)}
; {var1720=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier, var1507=r1, var3311=r0, var1326=null_type, var3871=java.lang.Object, var2584=r2, var1946=$z0, var1887=$l6, var3350=$b7, var2448=$i9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier=var1720, r1=var1507, r0=var3311, null_type=var1326, java.lang.Object=var3871, r2=var2584, $z0=var1946, $l6=var1887, $b7=var3350, $i9=var2448}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Object;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("configurators");	if $z0 != 0 goto virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2);	virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2);	$l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime>;	$b7 = $l6 cmp 0L;	$i9 = (int) $b7;	if $i9 > 0 goto $l0 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime>;	virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2);	goto [?= return];	return
;block_num 5