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

(declare-sort var1143 0)
(declare-sort var2952 0)
(declare-sort var3111 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serviceKey/2024389339 (var1143) String)
(declare-fun apps/2024389339 (var1143) var2952)
(declare-fun var3111_toString/-522406933 (var3111) String)
(declare-fun cast-from-var2952-to-var3111 (var2952) var3111)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1143 var1143)
(declare-const var3922 var1143) ; Statement: r1 := @this: org.apache.dubbo.metadata.MappingChangedEvent 
(assert (not (= var3922 null-var1143)))
(define-const var3401 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3401)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3401!1 String)
(assert (= var3401!1 ""))
(assert true)
(define-const var252 String (append/672562846 var3401!1 "{serviceKey: ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{serviceKey: ") 
(declare-const var3401!2 String)
(assert (= var3401!2 (str.++ var3401!1 "{serviceKey: ")))
(define-const var825 String (serviceKey/2024389339 var3922)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.MappingChangedEvent: java.lang.String serviceKey> 
(assert true)
(define-const var3231 String (append/672562846 var252 var825)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var252!1 String)
(assert (= var252!1 (str.++ var252 var825)))
(assert true)
(define-const var893 String (append/672562846 var3231 ", apps: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", apps: ") 
(declare-const var3231!1 String)
(assert (= var3231!1 (str.++ var3231 ", apps: ")))
(define-const var423 var2952 (apps/2024389339 var3922)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.MappingChangedEvent: java.util.Set apps> 
(define-const var1517 String (var3111_toString/-522406933 (cast-from-var2952-to-var3111 var423))) ; Statement: $r6 = interfaceinvoke $r5.<java.util.Set: java.lang.String toString()>() 
(assert true)
(define-const var2236 String (append/672562846 var893 var1517)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var893!1 String)
(assert (= var893!1 (str.++ var893 var1517)))
(assert true)
(define-const var2631 String (append/672562846 var2236 "}")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var2236!1 String)
(assert (= var2236!1 (str.++ var2236 "}")))
(assert true)
(define-const var412 String (toString/-2075883882 var2631)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serviceKey/2024389339=([org.apache.dubbo.metadata.MappingChangedEvent], java.lang.String), apps/2024389339=([org.apache.dubbo.metadata.MappingChangedEvent], java.util.Set), var3111_toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var2952-to-var3111=([java.util.Set], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1143=org.apache.dubbo.metadata.MappingChangedEvent, var3922=r1, var3401=$r0, var252=$r3, var825=$r2, var3231=$r4, var893=$r7, var2952=java.util.Set, var423=$r5, var3111=java.lang.Object, var1517=$r6, var2236=$r8, var2631=$r9, var412=$r10}
; {org.apache.dubbo.metadata.MappingChangedEvent=var1143, r1=var3922, $r0=var3401, $r3=var252, $r2=var825, $r4=var3231, $r7=var893, java.util.Set=var2952, $r5=var423, java.lang.Object=var3111, $r6=var1517, $r8=var2236, $r9=var2631, $r10=var412}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MappingChangedEvent;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{serviceKey: ");	$r2 = r1.<org.apache.dubbo.metadata.MappingChangedEvent: java.lang.String serviceKey>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", apps: ");	$r5 = r1.<org.apache.dubbo.metadata.MappingChangedEvent: java.util.Set apps>;	$r6 = interfaceinvoke $r5.<java.util.Set: java.lang.String toString()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1