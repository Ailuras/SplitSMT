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

(declare-sort var3114 0)
(declare-sort var3028 0)
(declare-sort var2937 0)
(declare-sort var639 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/-281142129 (var3114) String)
(declare-const null-var3114 var3114)
(declare-const null-String String)
(declare-const null-var2937 var2937)
(declare-const null-var639 var639)
(declare-const var181 var3114) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener 
(assert (not (= var181 null-var3114)))
(declare-const var562 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var562 null-String)))
(declare-const var1095 var2937) ; Statement: r5 := @parameter1: java.lang.Object 
(assert (not (= var1095 null-var2937)))
(declare-const var3870 var639) ; Statement: r3 := @parameter2: org.apache.dubbo.remoting.zookeeper.curator5.EventType 
(assert (not (= var3870 null-var639)))
(define-const var595 String (path/-281142129 var181)) ; Statement: $r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener: java.lang.String path> 
(assert true)
(define-const var1319 Bool (= var595 var562)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto $r4 = <org.apache.dubbo.remoting.zookeeper.curator5.EventType: org.apache.dubbo.remoting.zookeeper.curator5.EventType NodeCreated> 
(assert (not (not (= (ite var1319 1 0) 0)))) ; Negate: Cond: $z0 != 0  
 ; Statement: return 
(check-sat)
; {path/-281142129=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener], java.lang.String)}
; {var3114=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener, var181=r0, var562=r1, var3028=null_type, var2937=java.lang.Object, var1095=r5, var639=org.apache.dubbo.remoting.zookeeper.curator5.EventType, var3870=r3, var595=$r2, var1319=$z0}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener=var3114, r0=var181, r1=var562, null_type=var3028, java.lang.Object=var2937, r5=var1095, org.apache.dubbo.remoting.zookeeper.curator5.EventType=var639, r3=var3870, $r2=var595, $z0=var1319}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener;	r1 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.remoting.zookeeper.curator5.EventType;	$r2 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport$MappingDataListener: java.lang.String path>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto $r4 = <org.apache.dubbo.remoting.zookeeper.curator5.EventType: org.apache.dubbo.remoting.zookeeper.curator5.EventType NodeCreated>;	return
;block_num 2