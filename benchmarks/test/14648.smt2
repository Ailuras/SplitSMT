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

(declare-sort var2264 0)
(declare-sort var867 0)
(declare-sort var2916 0)
(declare-sort var2160 0)
(declare-sort var1424 0)
(declare-sort var637 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2916_buildKey/1628109746 (String String String) String)
(declare-fun getAllServiceURLs/-2039526524 (var2264) var2160)
(declare-fun getServiceURLs/-2127307880 (var2264 var2160 String String) var1424)
(declare-fun var637_unmodifiableSortedSet/-1102872800 (var1424) var1424)
(declare-const null-var2264 var2264)
(declare-const null-String String)
(declare-const var2748 var2264) ; Statement: r5 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation 
(assert (not (= var2748 null-var2264)))
(declare-const var3348 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3348 null-String)))
(declare-const var2417 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2417 null-String)))
(declare-const var1534 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1534 null-String)))
(declare-const var976 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var976 null-String)))
(define-const var2583 String "*") ; Statement: $r1 = "*" 
(assert true)
(define-const var3218 Bool (= var2583 var3348)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3) 
(assert (= (ite var3218 1 0) 0)) ; Cond: $z0 == 0 
(define-const var466 String (var2916_buildKey/1628109746 var3348 var2417 var1534)) ; Statement: r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3) 
(assert true)
(define-const var3973 var2160 (getAllServiceURLs/-2039526524 var2748)) ; Statement: $r7 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.Map getAllServiceURLs()>() 
(assert true)
(define-const var990 var1424 (getServiceURLs/-2127307880 var2748 var3973 var466 var976)) ; Statement: $r8 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.SortedSet getServiceURLs(java.util.Map,java.lang.String,java.lang.String)>($r7, r4, r6) 
(define-const var2907 var1424 (var637_unmodifiableSortedSet/-1102872800 var990)) ; Statement: $r9 = staticinvoke <java.util.Collections: java.util.SortedSet unmodifiableSortedSet(java.util.SortedSet)>($r8) 
 ; Statement: return $r9 
(check-sat)
; {var2916_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), getAllServiceURLs/-2039526524=([org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation], java.util.Map), getServiceURLs/-2127307880=([org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation, java.util.Map, java.lang.String, java.lang.String], java.util.SortedSet), var637_unmodifiableSortedSet/-1102872800=([java.util.SortedSet], java.util.SortedSet)}
; {var2264=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation, var2748=r5, var3348=r0, var867=null_type, var2417=r2, var1534=r3, var976=r6, var2583=$r1, var3218=$z0, var2916=org.apache.dubbo.common.URL, var466=r4, var2160=java.util.Map, var3973=$r7, var1424=java.util.SortedSet, var990=$r8, var637=java.util.Collections, var2907=$r9}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation=var2264, r5=var2748, r0=var3348, null_type=var867, r2=var2417, r3=var1534, r6=var976, $r1=var2583, $z0=var3218, org.apache.dubbo.common.URL=var2916, r4=var466, java.util.Map=var2160, $r7=var3973, java.util.SortedSet=var1424, $r8=var990, java.util.Collections=var637, $r9=var2907}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.String;	$r1 = "*";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3);	r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3);	$r7 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.Map getAllServiceURLs()>();	$r8 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.SortedSet getServiceURLs(java.util.Map,java.lang.String,java.lang.String)>($r7, r4, r6);	$r9 = staticinvoke <java.util.Collections: java.util.SortedSet unmodifiableSortedSet(java.util.SortedSet)>($r8);	return $r9
;block_num 2