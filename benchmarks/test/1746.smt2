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

(declare-sort var1474 0)
(declare-sort var1369 0)
(declare-sort var1874 0)
(declare-sort var3009 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun key/601958768 (var1474) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun group/601958768 (var1474) String)
(declare-fun content/601958768 (var1474) String)
(declare-fun changeType/601958768 (var1474) var1369)
(declare-fun append/-1031950772 (String var1874) String)
(declare-fun cast-from-var1369-to-var1874 (var1369) var1874)
(declare-fun toString/-2112557159 (var3009) String)
(declare-fun cast-from-var1474-to-var3009 (var1474) var3009)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1474 var1474)
(declare-const var3589 var1474) ; Statement: r1 := @this: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent 
(assert (not (= var3589 null-var1474)))
(define-const var491 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var491)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var491!1 String)
(assert (= var491!1 ""))
(assert true)
(define-const var2731 String (append/672562846 var491!1 "ConfigChangedEvent{key=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConfigChangedEvent{key=\'") 
(declare-const var491!2 String)
(assert (= var491!2 (str.++ var491!1 "ConfigChangedEvent{key=\u0027")))
(define-const var3888 String (key/601958768 var3589)) ; Statement: $r2 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String key> 
(assert true)
(define-const var1933 String (append/672562846 var2731 var3888)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2731!1 String)
(assert (= var2731!1 (str.++ var2731 var3888)))
(assert true)
(define-const var710 String (append/-1166366385 var1933 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1933!1 String)
(assert (str.prefixof var1933 var1933!1))
(assert true)
(define-const var1448 String (append/672562846 var710 ", group=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group=\'") 
(declare-const var710!1 String)
(assert (= var710!1 (str.++ var710 ", group=\u0027")))
(define-const var3933 String (group/601958768 var3589)) ; Statement: $r6 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String group> 
(assert true)
(define-const var1256 String (append/672562846 var1448 var3933)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1448!1 String)
(assert (= var1448!1 (str.++ var1448 var3933)))
(assert true)
(define-const var56 String (append/-1166366385 var1256 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1256!1 String)
(assert (str.prefixof var1256 var1256!1))
(assert true)
(define-const var1655 String (append/672562846 var56 ", content=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", content=\'") 
(declare-const var56!1 String)
(assert (= var56!1 (str.++ var56 ", content=\u0027")))
(define-const var2684 String (content/601958768 var3589)) ; Statement: $r10 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String content> 
(assert true)
(define-const var2414 String (append/672562846 var1655 var2684)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1655!1 String)
(assert (= var1655!1 (str.++ var1655 var2684)))
(assert true)
(define-const var2012 String (append/-1166366385 var2414 39)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2414!1 String)
(assert (str.prefixof var2414 var2414!1))
(assert true)
(define-const var3875 String (append/672562846 var2012 ", changeType=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", changeType=") 
(declare-const var2012!1 String)
(assert (= var2012!1 (str.++ var2012 ", changeType=")))
(define-const var615 var1369 (changeType/601958768 var3589)) ; Statement: $r14 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType changeType> 
(assert true)
(define-const var892 String (append/-1031950772 var3875 (cast-from-var1369-to-var1874 var615))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var3875!1 String)
(assert (str.prefixof var3875 var3875!1))
(assert true)
(define-const var1941 String (append/672562846 var892 "} ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ") 
(declare-const var892!1 String)
(assert (= var892!1 (str.++ var892 "} ")))
(assert true)
(define-const var3963 String (toString/-2112557159 (cast-from-var1474-to-var3009 var3589))) ; Statement: $r17 = specialinvoke r1.<java.util.EventObject: java.lang.String toString()>() 
(assert true)
(define-const var364 String (append/672562846 var1941 var3963)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var1941!1 String)
(assert (= var1941!1 (str.++ var1941 var3963)))
(assert true)
(define-const var1512 String (toString/-2075883882 var364)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), key/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), group/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), content/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), changeType/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], org.apache.dubbo.common.config.configcenter.ConfigChangeType), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1369-to-var1874=([org.apache.dubbo.common.config.configcenter.ConfigChangeType], java.lang.Object), toString/-2112557159=([java.util.EventObject], java.lang.String), cast-from-var1474-to-var3009=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.util.EventObject), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1474=org.apache.dubbo.common.config.configcenter.ConfigChangedEvent, var3589=r1, var491=$r0, var2731=$r3, var3888=$r2, var1933=$r4, var710=$r5, var1448=$r7, var3933=$r6, var1256=$r8, var56=$r9, var1655=$r11, var2684=$r10, var2414=$r12, var2012=$r13, var3875=$r15, var1369=org.apache.dubbo.common.config.configcenter.ConfigChangeType, var615=$r14, var1874=java.lang.Object, var892=$r16, var1941=$r18, var3009=java.util.EventObject, var3963=$r17, var364=$r19, var1512=$r20}
; {org.apache.dubbo.common.config.configcenter.ConfigChangedEvent=var1474, r1=var3589, $r0=var491, $r3=var2731, $r2=var3888, $r4=var1933, $r5=var710, $r7=var1448, $r6=var3933, $r8=var1256, $r9=var56, $r11=var1655, $r10=var2684, $r12=var2414, $r13=var2012, $r15=var3875, org.apache.dubbo.common.config.configcenter.ConfigChangeType=var1369, $r14=var615, java.lang.Object=var1874, $r16=var892, $r18=var1941, java.util.EventObject=var3009, $r17=var3963, $r19=var364, $r20=var1512}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.EventObject: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConfigChangedEvent{key=\'");	$r2 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String key>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group=\'");	$r6 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String group>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", content=\'");	$r10 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String content>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", changeType=");	$r14 = r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType changeType>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ");	$r17 = specialinvoke r1.<java.util.EventObject: java.lang.String toString()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 1