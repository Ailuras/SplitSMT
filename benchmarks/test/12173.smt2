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

(declare-sort var1114 0)
(declare-sort var1413 0)
(declare-sort var2383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/756131061 (var1114) String)
(declare-fun group/756131061 (var1114) String)
(declare-fun version/756131061 (var1114) String)
(declare-fun protocol/756131061 (var1114) String)
(declare-fun port/756131061 (var1114) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun params/756131061 (var1114) var1413)
(declare-fun append/-1031950772 (String var2383) String)
(declare-fun cast-from-var1413-to-var2383 (var1413) var2383)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1114 var1114)
(declare-const var3931 var1114) ; Statement: r1 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var3931 null-var1114)))
(define-const var561 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var561)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var561!1 String)
(assert (= var561!1 ""))
(assert true)
(define-const var3798 String (append/672562846 var561!1 "service{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service{name=\'") 
(declare-const var561!2 String)
(assert (= var561!2 (str.++ var561!1 "service{name=\u0027")))
(define-const var2551 String (name/756131061 var3931)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String name> 
(assert true)
(define-const var3563 String (append/672562846 var3798 var2551)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3798!1 String)
(assert (= var3798!1 (str.++ var3798 var2551)))
(assert true)
(define-const var1181 String (append/672562846 var3563 "\u0027,group=\u0027")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',group=\'") 
(declare-const var3563!1 String)
(assert (= var3563!1 (str.++ var3563 "\u0027,group=\u0027")))
(define-const var3004 String (group/756131061 var3931)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String group> 
(assert true)
(define-const var2857 String (append/672562846 var1181 var3004)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1181!1 String)
(assert (= var1181!1 (str.++ var1181 var3004)))
(assert true)
(define-const var729 String (append/672562846 var2857 "\u0027,version=\u0027")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',version=\'") 
(declare-const var2857!1 String)
(assert (= var2857!1 (str.++ var2857 "\u0027,version=\u0027")))
(define-const var3069 String (version/756131061 var3931)) ; Statement: $r8 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String version> 
(assert true)
(define-const var376 String (append/672562846 var729 var3069)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var729!1 String)
(assert (= var729!1 (str.++ var729 var3069)))
(assert true)
(define-const var3968 String (append/672562846 var376 "\u0027,protocol=\u0027")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',protocol=\'") 
(declare-const var376!1 String)
(assert (= var376!1 (str.++ var376 "\u0027,protocol=\u0027")))
(define-const var113 String (protocol/756131061 var3931)) ; Statement: $r11 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String protocol> 
(assert true)
(define-const var2085 String (append/672562846 var3968 var113)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3968!1 String)
(assert (= var3968!1 (str.++ var3968 var113)))
(assert true)
(define-const var676 String (append/672562846 var2085 "\u0027,port=\u0027")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',port=\'") 
(declare-const var2085!1 String)
(assert (= var2085!1 (str.++ var2085 "\u0027,port=\u0027")))
(define-const var1298 Int (port/756131061 var3931)) ; Statement: $i0 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: int port> 
(assert true)
(define-const var995 String (append/-1001720160 var676 var1298)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var676!1 String)
(assert (str.prefixof var676 var676!1))
(assert true)
(define-const var864 String (append/672562846 var995 "\u0027,params=")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',params=") 
(declare-const var995!1 String)
(assert (= var995!1 (str.++ var995 "\u0027,params=")))
(define-const var1602 var1413 (params/756131061 var3931)) ; Statement: $r16 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.util.Map params> 
(assert true)
(define-const var2790 String (append/-1031950772 var864 (cast-from-var1413-to-var2383 var1602))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16) 
(declare-const var864!1 String)
(assert (str.prefixof var864 var864!1))
(assert true)
(define-const var3407 String (append/672562846 var2790 ",}")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",}") 
(declare-const var2790!1 String)
(assert (= var2790!1 (str.++ var2790 ",}")))
(assert true)
(define-const var679 String (toString/-2075883882 var3407)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), group/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), version/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), protocol/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.lang.String), port/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), params/756131061=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1413-to-var2383=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1114=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var3931=r1, var561=$r0, var3798=$r3, var2551=$r2, var3563=$r4, var1181=$r6, var3004=$r5, var2857=$r7, var729=$r9, var3069=$r8, var376=$r10, var3968=$r12, var113=$r11, var2085=$r13, var676=$r14, var1298=$i0, var995=$r15, var864=$r17, var1413=java.util.Map, var1602=$r16, var2383=java.lang.Object, var2790=$r18, var3407=$r19, var679=$r20}
; {org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var1114, r1=var3931, $r0=var561, $r3=var3798, $r2=var2551, $r4=var3563, $r6=var1181, $r5=var3004, $r7=var2857, $r9=var729, $r8=var3069, $r10=var376, $r12=var3968, $r11=var113, $r13=var2085, $r14=var676, $i0=var1298, $r15=var995, $r17=var864, java.util.Map=var1413, $r16=var1602, java.lang.Object=var2383, $r18=var2790, $r19=var3407, $r20=var679}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 11,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service{name=\'");	$r2 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',group=\'");	$r5 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String group>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',version=\'");	$r8 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String version>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',protocol=\'");	$r11 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String protocol>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',port=\'");	$i0 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: int port>;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',params=");	$r16 = r1.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.util.Map params>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",}");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 1