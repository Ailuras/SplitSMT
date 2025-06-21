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

(declare-sort var3763 0)
(declare-sort var3666 0)
(declare-sort var1582 0)
(declare-sort var3537 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun instanceParams/-2112725066 (var3763) var1582)
(declare-fun var1582_put/1464166817 (var1582 var3537 var3537) var3537)
(declare-fun cast-from-String-to-var3537 (String) var3537)
(declare-fun cast-from-var3537-to-String (var3537) String)
(declare-const null-var3763 var3763)
(declare-const null-String String)
(declare-const var1017 var3763) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var1017 null-var3763)))
(declare-const var2130 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2130 null-String)))
(declare-const var2263 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2263 null-String)))
(define-const var2644 var1582 (instanceParams/-2112725066 var1017)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map instanceParams> 
(define-const var2659 var3537 (var1582_put/1464166817 var2644 (cast-from-String-to-var3537 var2130) (cast-from-String-to-var3537 var2263))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2) 
(define-const var1724 String (cast-from-var3537-to-String var2659)) ; Statement: r5 = (java.lang.String) $r4 
(define-const var814 String "timestamp") ; Statement: $r6 = "timestamp" 
(assert true)
(define-const var1341 Bool (= var814 var2130)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1341 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {instanceParams/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.util.Map), var1582_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3537=([java.lang.String], java.lang.Object), cast-from-var3537-to-String=([java.lang.Object], java.lang.String)}
; {var3763=org.apache.dubbo.metadata.MetadataInfo, var1017=r0, var2130=r1, var3666=null_type, var2263=r2, var1582=java.util.Map, var2644=$r3, var3537=java.lang.Object, var2659=$r4, var1724=r5, var814=$r6, var1341=$z0}
; {org.apache.dubbo.metadata.MetadataInfo=var3763, r0=var1017, r1=var2130, null_type=var3666, r2=var2263, java.util.Map=var1582, $r3=var2644, java.lang.Object=var3537, $r4=var2659, r5=var1724, $r6=var814, $z0=var1341}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataInfo;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r3 = r0.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map instanceParams>;	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2);	r5 = (java.lang.String) $r4;	$r6 = "timestamp";	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto return;	return
;block_num 2