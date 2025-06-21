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

(declare-sort var1055 0)
(declare-sort var815 0)
(declare-sort var3863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun expressions/1609652760 (var1055) var815)
(declare-fun append/-1031950772 (String var3863) String)
(declare-fun cast-from-var815-to-var3863 (var815) var3863)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1055 var1055)
(declare-const var3237 var1055) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition 
(assert (not (= var3237 null-var1055)))
(define-const var3156 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3156)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3156!1 String)
(assert (= var3156!1 ""))
(assert true)
(define-const var3099 String (append/672562846 var3156!1 "HeadersCondition{headers=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HeadersCondition{headers=") 
(declare-const var3156!2 String)
(assert (= var3156!2 (str.++ var3156!1 "HeadersCondition{headers=")))
(define-const var1317 var815 (expressions/1609652760 var3237)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition: java.util.Set expressions> 
(assert true)
(define-const var2411 String (append/-1031950772 var3099 (cast-from-var815-to-var3863 var1317))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3099!1 String)
(assert (str.prefixof var3099 var3099!1))
(assert true)
(define-const var3882 String (append/-1166366385 var2411 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2411!1 String)
(assert (str.prefixof var2411 var2411!1))
(assert true)
(define-const var1198 String (toString/-2075883882 var3882)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), expressions/1609652760=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition], java.util.Set), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var815-to-var3863=([java.util.Set], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1055=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition, var3237=r1, var3156=$r0, var3099=$r3, var815=java.util.Set, var1317=$r2, var3863=java.lang.Object, var2411=$r4, var3882=$r5, var1198=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition=var1055, r1=var3237, $r0=var3156, $r3=var3099, java.util.Set=var815, $r2=var1317, java.lang.Object=var3863, $r4=var2411, $r5=var3882, $r6=var1198}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HeadersCondition{headers=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.HeadersCondition: java.util.Set expressions>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1