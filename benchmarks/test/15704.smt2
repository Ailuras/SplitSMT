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

(declare-sort var949 0)
(declare-sort var3304 0)
(declare-sort var3009 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun id/1149606292 (var949) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun name/1149606292 (var949) String)
(declare-fun metadata/1149606292 (var949) var3304)
(declare-fun append/-1031950772 (String var3009) String)
(declare-fun cast-from-var3304-to-var3009 (var3304) var3009)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var949 var949)
(declare-const var601 var949) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperInstance 
(assert (not (= var601 null-var949)))
(define-const var112 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var112)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var112!1 String)
(assert (= var112!1 ""))
(assert true)
(define-const var1798 String (append/672562846 var112!1 "ZookeeperInstance{id=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZookeeperInstance{id=\'") 
(declare-const var112!2 String)
(assert (= var112!2 (str.++ var112!1 "ZookeeperInstance{id=\u0027")))
(define-const var2125 String (id/1149606292 var601)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.lang.String id> 
(assert true)
(define-const var3363 String (append/672562846 var1798 var2125)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1798!1 String)
(assert (= var1798!1 (str.++ var1798 var2125)))
(assert true)
(define-const var2542 String (append/-1166366385 var3363 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3363!1 String)
(assert (str.prefixof var3363 var3363!1))
(assert true)
(define-const var3217 String (append/672562846 var2542 ", name=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", name=\'") 
(declare-const var2542!1 String)
(assert (= var2542!1 (str.++ var2542 ", name=\u0027")))
(define-const var3904 String (name/1149606292 var601)) ; Statement: $r6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.lang.String name> 
(assert true)
(define-const var1379 String (append/672562846 var3217 var3904)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3217!1 String)
(assert (= var3217!1 (str.++ var3217 var3904)))
(assert true)
(define-const var2350 String (append/-1166366385 var1379 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1379!1 String)
(assert (str.prefixof var1379 var1379!1))
(assert true)
(define-const var214 String (append/672562846 var2350 ", metadata=")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=") 
(declare-const var2350!1 String)
(assert (= var2350!1 (str.++ var2350 ", metadata=")))
(define-const var750 var3304 (metadata/1149606292 var601)) ; Statement: $r10 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.util.Map metadata> 
(assert true)
(define-const var712 String (append/-1031950772 var214 (cast-from-var3304-to-var3009 var750))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var214!1 String)
(assert (str.prefixof var214 var214!1))
(assert true)
(define-const var254 String (append/-1166366385 var712 125)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var712!1 String)
(assert (str.prefixof var712 var712!1))
(assert true)
(define-const var3743 String (toString/-2075883882 var254)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), id/1149606292=([org.apache.dubbo.registry.zookeeper.ZookeeperInstance], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), name/1149606292=([org.apache.dubbo.registry.zookeeper.ZookeeperInstance], java.lang.String), metadata/1149606292=([org.apache.dubbo.registry.zookeeper.ZookeeperInstance], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3304-to-var3009=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var949=org.apache.dubbo.registry.zookeeper.ZookeeperInstance, var601=r1, var112=$r0, var1798=$r3, var2125=$r2, var3363=$r4, var2542=$r5, var3217=$r7, var3904=$r6, var1379=$r8, var2350=$r9, var214=$r11, var3304=java.util.Map, var750=$r10, var3009=java.lang.Object, var712=$r12, var254=$r13, var3743=$r14}
; {org.apache.dubbo.registry.zookeeper.ZookeeperInstance=var949, r1=var601, $r0=var112, $r3=var1798, $r2=var2125, $r4=var3363, $r5=var2542, $r7=var3217, $r6=var3904, $r8=var1379, $r9=var2350, $r11=var214, java.util.Map=var3304, $r10=var750, java.lang.Object=var3009, $r12=var712, $r13=var254, $r14=var3743}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperInstance;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZookeeperInstance{id=\'");	$r2 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.lang.String id>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", name=\'");	$r6 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.lang.String name>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", metadata=");	$r10 = r1.<org.apache.dubbo.registry.zookeeper.ZookeeperInstance: java.util.Map metadata>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 1