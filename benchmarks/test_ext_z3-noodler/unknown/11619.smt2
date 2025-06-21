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

(declare-sort var1678 0)
(declare-sort var1858 0)
(declare-sort var531 0)
(declare-sort var1797 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getMatchKey/2081451185 (var1678) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun port/756131061 (var1678) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun path/756131061 (var1678) String)
(declare-fun var1858-init () var1858)
(declare-fun getParams/-1126283844 (var1678) var531)
(declare-fun <init>/637216031 (var1858 var531) void)
(declare-fun append/-1031950772 (String var1797) String)
(declare-fun cast-from-var1858-to-var1797 (var1858) var1797)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1678 var1678)
(declare-const var3864 var1678) ; Statement: r1 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var3864 null-var1678)))
(define-const var1061 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1061)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1061!1 String)
(assert (= var1061!1 ""))
(assert true)
(define-const var2065 String (getMatchKey/2081451185 var3864)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getMatchKey()>() 
(assert true)
(define-const var1102 String (append/672562846 var1061!1 var2065)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1061!2 String)
(assert (= var1061!2 (str.++ var1061!1 var2065)))
(define-const var1508 Int (port/756131061 var3864)) ; Statement: $i0 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: int port> 
(assert true)
(define-const var989 String (append/-1001720160 var1102 var1508)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1102!1 String)
(assert (str.prefixof var1102 var1102!1))
(define-const var2498 String (path/756131061 var3864)) ; Statement: $r4 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String path> 
(assert true)
(define-const var3246 String (append/672562846 var989 var2498)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var989!1 String)
(assert (= var989!1 (str.++ var989 var2498)))
(define-const var1289 var1858 var1858-init) ; Statement: $r6 = new java.util.TreeMap 
(assert true)
(define-const var2696 var531 (getParams/-1126283844 var3864)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.util.Map getParams()>() 
(assert true)
;(assert (<init>/637216031 var1289 var2696)) ; Statement: specialinvoke $r6.<java.util.TreeMap: void <init>(java.util.Map)>($r7) 

(declare-const var1289!1 var1858)
(declare-const var2696!1 var531)
(assert true)
(define-const var3728 String (append/-1031950772 var3246 (cast-from-var1858-to-var1797 var1289!1))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var3246!1 String)
(assert (str.prefixof var3246 var3246!1))
(assert true)
(define-const var3870 String (toString/-2075883882 var3728)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getMatchKey/2081451185=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), port/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), path/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), var1858-init=([], java.util.TreeMap), getParams/-1126283844=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.util.Map), <init>/637216031=([java.util.TreeMap, java.util.Map], void), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1858-to-var1797=([java.util.TreeMap], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1678=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var3864=r1, var1061=$r0, var2065=$r2, var1102=$r3, var1508=$i0, var989=$r5, var2498=$r4, var3246=$r8, var1858=java.util.TreeMap, var1289=$r6, var531=java.util.Map, var2696=$r7, var1797=java.lang.Object, var3728=$r9, var3870=$r10}
; {org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1678, r1=var3864, $r0=var1061, $r2=var2065, $r3=var1102, $i0=var1508, $r5=var989, $r4=var2498, $r8=var3246, java.util.TreeMap=var1858, $r6=var1289, java.util.Map=var531, $r7=var2696, java.lang.Object=var1797, $r9=var3728, $r10=var3870}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getMatchKey()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$i0 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: int port>;	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r4 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String path>;	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = new java.util.TreeMap;	$r7 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.util.Map getParams()>();	specialinvoke $r6.<java.util.TreeMap: void <init>(java.util.Map)>($r7);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1