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

(declare-sort var1179 0)
(declare-sort var3046 0)
(declare-sort var2026 0)
(declare-sort var1309 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/757917112 (var1179) String)
(declare-const null-var1179 var1179)
(declare-const null-String String)
(declare-const null-var2026 var2026)
(declare-const null-var1309 var1309)
(declare-const var1912 var1179) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener 
(assert (not (= var1912 null-var1179)))
(declare-const var1744 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1744 null-String)))
(declare-const var3966 var2026) ; Statement: r5 := @parameter1: java.lang.Object 
(assert (not (= var3966 null-var2026)))
(declare-const var2710 var1309) ; Statement: r3 := @parameter2: org.apache.dubbo.remoting.zookeeper.curator5.EventType 
(assert (not (= var2710 null-var1309)))
(define-const var806 String (path/757917112 var1912)) ; Statement: $r2 = r0.<org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener: java.lang.String path> 
(assert true)
(define-const var117 Bool (= var806 var1744)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto $r4 = <org.apache.dubbo.remoting.zookeeper.curator5.EventType: org.apache.dubbo.remoting.zookeeper.curator5.EventType NodeCreated> 
(assert (not (not (= (ite var117 1 0) 0)))) ; Negate: Cond: $z0 != 0  
 ; Statement: return 
(check-sat)
; {path/757917112=([org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener], java.lang.String)}
; {var1179=org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener, var1912=r0, var1744=r1, var3046=null_type, var2026=java.lang.Object, var3966=r5, var1309=org.apache.dubbo.remoting.zookeeper.curator5.EventType, var2710=r3, var806=$r2, var117=$z0}
; {org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener=var1179, r0=var1912, r1=var1744, null_type=var3046, java.lang.Object=var2026, r5=var3966, org.apache.dubbo.remoting.zookeeper.curator5.EventType=var1309, r3=var2710, $r2=var806, $z0=var117}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener;	r1 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.remoting.zookeeper.curator5.EventType;	$r2 = r0.<org.apache.dubbo.configcenter.support.zookeeper.ZookeeperDataListener: java.lang.String path>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto $r4 = <org.apache.dubbo.remoting.zookeeper.curator5.EventType: org.apache.dubbo.remoting.zookeeper.curator5.EventType NodeCreated>;	return
;block_num 2