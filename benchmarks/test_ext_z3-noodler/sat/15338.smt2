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

(declare-sort var576 0)
(declare-sort var200 0)
(declare-sort var301 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun delayTime/1655264999 (var576) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun doNotify/100853974 (var576 String var301) void)
(declare-const null-var576 var576)
(declare-const null-String String)
(declare-const null-var301 var301)
(declare-const var3942 var576) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier 
(assert (not (= var3942 null-var576)))
(declare-const var2575 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2575 null-String)))
(declare-const var999 var301) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var999 null-var301)))
(assert true)
(define-const var1001 Bool (endsWith/985337093 var2575 "configurators")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("configurators") 
 ; Statement: if $z0 != 0 goto virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2) 
(assert (not (not (= (ite var1001 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var1295 Bool (endsWith/985337093 var2575 "routers")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("routers") 
 ; Statement: if $z1 == 0 goto $l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime> 
(assert (= (ite var1295 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3735 Int (delayTime/1655264999 var3942)) ; Statement: $l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime> 
(define-const var3174 Int (ite (> var3735 0) 1 (ite (< var3735 0) -1 0))) ; Statement: $b7 = $l6 cmp 0L 
(define-const var293 Int (cast-from-Int-to-Int var3174)) ; Statement: $i9 = (int) $b7 
 ; Statement: if $i9 > 0 goto $l0 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime> 
(assert (not (> var293 0))) ; Negate: Cond: $i9 > 0  
(assert true)
;(assert (doNotify/100853974 var3942 var2575 var999)) ; Statement: virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2) 

(declare-const var3942!1 var576)
(declare-const var2575!1 String)
(declare-const var999!1 var301)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), delayTime/1655264999=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier], long), cast-from-Int-to-Int=([byte], int), doNotify/100853974=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier, java.lang.String, java.lang.Object], void)}
; {var576=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier, var3942=r1, var2575=r0, var200=null_type, var301=java.lang.Object, var999=r2, var1001=$z0, var1295=$z1, var3735=$l6, var3174=$b7, var293=$i9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier=var576, r1=var3942, r0=var2575, null_type=var200, java.lang.Object=var301, r2=var999, $z0=var1001, $z1=var1295, $l6=var3735, $b7=var3174, $i9=var293}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Object;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("configurators");	if $z0 != 0 goto virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2);	$z1 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("routers");	if $z1 == 0 goto $l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime>;	$l6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime>;	$b7 = $l6 cmp 0L;	$i9 = (int) $b7;	if $i9 > 0 goto $l0 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: long delayTime>;	virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry$ZookeeperRegistryNotifier: void doNotify(java.lang.String,java.lang.Object)>(r0, r2);	goto [?= return];	return
;block_num 5