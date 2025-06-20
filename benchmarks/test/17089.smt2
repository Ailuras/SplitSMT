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

(declare-sort var148 0)
(declare-sort var1235 0)
(declare-sort var3857 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getColonSeparatedKey/1043071031 (var1235) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var148 var148)
(declare-const null-var1235 var1235)
(declare-const null-String String)
(declare-const var148-SERVICE_NAME_SEPARATOR String)
(declare-const var2120 var148) ; Statement: r9 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2120 null-var148)))
(declare-const var3684 var1235) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3684 null-var1235)))
(declare-const var3230 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3230 null-String)))
(define-const var920 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var920)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var920!1 String)
(assert (= var920!1 ""))
(assert true)
(define-const var467 String (append/672562846 var920!1 var3230)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var920!2 String)
(assert (= var920!2 (str.++ var920!1 var3230)))
(define-const var2274 String var148-SERVICE_NAME_SEPARATOR) ; Statement: $r2 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(assert true)
(define-const var1204 String (append/672562846 var467 var2274)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var467!1 String)
(assert (= var467!1 (str.++ var467 var2274)))
(assert true)
(define-const var1918 String (getColonSeparatedKey/1043071031 var3684)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getColonSeparatedKey()>() 
(assert true)
(define-const var661 String (append/672562846 var1204 var1918)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1204!1 String)
(assert (= var1204!1 (str.++ var1204 var1918)))
(assert true)
(define-const var47 String (toString/-2075883882 var661)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getColonSeparatedKey/1043071031=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var148=org.apache.dubbo.registry.nacos.NacosRegistry, var2120=r9, var1235=org.apache.dubbo.common.URL, var3684=r4, var3230=r1, var3857=null_type, var920=$r0, var467=$r3, var2274=$r2, var1204=$r6, var1918=$r5, var661=$r7, var47=$r8}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var148, r9=var2120, org.apache.dubbo.common.URL=var1235, r4=var3684, r1=var3230, null_type=var3857, $r0=var920, $r3=var467, $r2=var2274, $r6=var1204, $r5=var1918, $r7=var661, $r8=var47}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r4 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r2 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getColonSeparatedKey()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1