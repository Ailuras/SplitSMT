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

(declare-sort var2060 0)
(declare-sort var2429 0)
(declare-sort var3485 0)
(declare-sort var665 0)
(declare-sort var330 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun consumerUrl/1343906212 (var2060) var2429)
(declare-fun getServiceKey/1456125852 (var2429) String)
(declare-fun decideInvoker/1764990038 (var2060) var3485)
(declare-fun append/-1031950772 (String var665) String)
(declare-fun cast-from-var3485-to-var665 (var3485) var665)
(declare-fun step/1343906212 (var2060) var330)
(declare-fun cast-from-var330-to-var665 (var330) var665)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2060 var2060)
(declare-const var2530 var2060) ; Statement: r1 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker 
(assert (not (= var2530 null-var2060)))
(define-const var2298 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2298)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2298!1 String)
(assert (= var2298!1 ""))
(assert true)
(define-const var1894 String (append/672562846 var2298!1 "MigrationInvoker{serviceKey=")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MigrationInvoker{serviceKey=") 
(declare-const var2298!2 String)
(assert (= var2298!2 (str.++ var2298!1 "MigrationInvoker{serviceKey=")))
(define-const var2400 var2429 (consumerUrl/1343906212 var2530)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var374 String (getServiceKey/1456125852 var2400)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2575 String (append/672562846 var1894 var374)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1894!1 String)
(assert (= var1894!1 (str.++ var1894 var374)))
(assert true)
(define-const var2885 String (append/672562846 var2575 ", invoker=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", invoker=") 
(declare-const var2575!1 String)
(assert (= var2575!1 (str.++ var2575 ", invoker=")))
(assert true)
(define-const var1948 var3485 (decideInvoker/1764990038 var2530)) ; Statement: $r6 = specialinvoke r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker decideInvoker()>() 
(assert true)
(define-const var1358 String (append/-1031950772 var2885 (cast-from-var3485-to-var665 var1948))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var2885!1 String)
(assert (str.prefixof var2885 var2885!1))
(assert true)
(define-const var2144 String (append/672562846 var1358 ", step=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", step=") 
(declare-const var1358!1 String)
(assert (= var1358!1 (str.++ var1358 ", step=")))
(define-const var3109 var330 (step/1343906212 var2530)) ; Statement: $r9 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.registry.client.migration.model.MigrationStep step> 
(assert true)
(define-const var1650 String (append/-1031950772 var2144 (cast-from-var330-to-var665 var3109))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var2144!1 String)
(assert (str.prefixof var2144 var2144!1))
(assert true)
(define-const var551 String (append/-1166366385 var1650 125)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1650!1 String)
(assert (str.prefixof var1650 var1650!1))
(assert true)
(define-const var138 String (toString/-2075883882 var551)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), consumerUrl/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), decideInvoker/1764990038=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.rpc.cluster.ClusterInvoker), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3485-to-var665=([org.apache.dubbo.rpc.cluster.ClusterInvoker], java.lang.Object), step/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.registry.client.migration.model.MigrationStep), cast-from-var330-to-var665=([org.apache.dubbo.registry.client.migration.model.MigrationStep], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2060=org.apache.dubbo.registry.client.migration.MigrationInvoker, var2530=r1, var2298=$r0, var1894=$r4, var2429=org.apache.dubbo.common.URL, var2400=$r2, var374=$r3, var2575=$r5, var2885=$r7, var3485=org.apache.dubbo.rpc.cluster.ClusterInvoker, var1948=$r6, var665=java.lang.Object, var1358=$r8, var2144=$r10, var330=org.apache.dubbo.registry.client.migration.model.MigrationStep, var3109=$r9, var1650=$r11, var551=$r12, var138=$r13}
; {org.apache.dubbo.registry.client.migration.MigrationInvoker=var2060, r1=var2530, $r0=var2298, $r4=var1894, org.apache.dubbo.common.URL=var2429, $r2=var2400, $r3=var374, $r5=var2575, $r7=var2885, org.apache.dubbo.rpc.cluster.ClusterInvoker=var3485, $r6=var1948, java.lang.Object=var665, $r8=var1358, $r10=var2144, org.apache.dubbo.registry.client.migration.model.MigrationStep=var330, $r9=var3109, $r11=var1650, $r12=var551, $r13=var138}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MigrationInvoker{serviceKey=");	$r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL consumerUrl>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", invoker=");	$r6 = specialinvoke r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.rpc.cluster.ClusterInvoker decideInvoker()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", step=");	$r9 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.registry.client.migration.model.MigrationStep step>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1