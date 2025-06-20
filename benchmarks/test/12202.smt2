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

(declare-sort var3791 0)
(declare-sort var3538 0)
(declare-sort var2014 0)
(declare-sort var2910 0)
(declare-sort var2463 0)
(declare-sort var1071 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2014_bootstrap$/-929334600 () var3538)
(declare-fun map/1305667865 (var3791 var3538) var3791)
(declare-fun var2910_bootstrap$/-1748274352 () var3538)
(declare-fun orElse/-757175127 (var3791 var2463) var2463)
(declare-fun cast-from-var2463-to-String (var2463) String)
(declare-const null-var3791 var3791)
(declare-const null-NullType var1071)
(declare-const null-var2463 var2463)
(declare-const var1583 var3791) ; Statement: r0 := @parameter0: java.util.Optional 
(assert (not (= var1583 null-var3791)))
(define-const var807 var3538 var2014_bootstrap$/-929334600) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getClass__580: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var3137 var3791 (map/1305667865 var1583 var807)) ; Statement: $r3 = virtualinvoke r0.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r1) 
(define-const var476 var3538 var2910_bootstrap$/-1748274352) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getName__590: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var2204 var3791 (map/1305667865 var3137 var476)) ; Statement: $r4 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2) 
(assert true)
(define-const var1824 var2463 (orElse/-757175127 var2204 null-var2463)) ; Statement: $r5 = virtualinvoke $r4.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var519 String (cast-from-var2463-to-String var1824)) ; Statement: r6 = (java.lang.String) $r5 
(define-const var3011 String "sun.nio.fs.PollingWatchService") ; Statement: $r7 = "sun.nio.fs.PollingWatchService" 
(assert true)
(define-const var1614 Bool (= var3011 var519)) ; Statement: $z0 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r6) 
 ; Statement: return $z0 
(check-sat)
; {var2014_bootstrap$/-929334600=([], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), var2910_bootstrap$/-1748274352=([], java.util.function.Function), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var2463-to-String=([java.lang.Object], java.lang.String)}
; {var3791=java.util.Optional, var1583=r0, var3538=java.util.function.Function, var2014=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getClass__580, var807=$r1, var3137=$r3, var2910=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getName__590, var476=$r2, var2204=$r4, var2463=java.lang.Object, var1824=$r5, var519=r6, var3011=$r7, var1614=$z0, var1071=null_type}
; {java.util.Optional=var3791, r0=var1583, java.util.function.Function=var3538, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getClass__580=var2014, $r1=var807, $r3=var3137, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getName__590=var2910, $r2=var476, $r4=var2204, java.lang.Object=var2463, $r5=var1824, r6=var519, $r7=var3011, $z0=var1614, null_type=var1071}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.util.Optional;	$r1 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getClass__580: java.util.function.Function bootstrap$()>();	$r3 = virtualinvoke r0.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r1);	$r2 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$getName__590: java.util.function.Function bootstrap$()>();	$r4 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2);	$r5 = virtualinvoke $r4.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	r6 = (java.lang.String) $r5;	$r7 = "sun.nio.fs.PollingWatchService";	$z0 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r6);	return $z0
;block_num 1