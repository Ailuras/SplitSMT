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

(declare-sort var2711 0)
(declare-sort var1114 0)
(declare-sort var1653 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1978845529 (var1653 Int String) void)
(declare-fun cast-from-var2711-to-var1653 (var2711) var1653)
(declare-fun mediaType/1125459975 (var2711) String)
(declare-const null-var2711 var2711)
(declare-const null-String String)
(declare-const var2119 var2711) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException 
(assert (not (= var2119 null-var2711)))
(declare-const var2273 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2273 null-String)))
(define-const var2210 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2210)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2210!1 String)
(assert (= var2210!1 ""))
(assert true)
(define-const var1435 String (append/672562846 var2210!1 "Unsupported Media Type \u0027")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported Media Type \'") 
(declare-const var2210!2 String)
(assert (= var2210!2 (str.++ var2210!1 "Unsupported Media Type \u0027")))
(assert true)
(define-const var2380 String (append/672562846 var1435 var2273)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1435!1 String)
(assert (= var1435!1 (str.++ var1435 var2273)))
(assert true)
(define-const var3600 String (append/672562846 var2380 "\u0027")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'") 
(declare-const var2380!1 String)
(assert (= var2380!1 (str.++ var2380 "\u0027")))
(assert true)
(define-const var2385 String (toString/-2075883882 var3600)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1978845529 (cast-from-var2711-to-var1653 var2119) 415 var2385)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: void <init>(int,java.lang.String)>(415, $r6) 

(declare-const var2119!1 var2711)
(declare-const var3613 Int)
(declare-const var2385!1 String)
(declare-const var2119!2 var2711)
(assert (not (= var2119!2 null-var2711)))
(assert (= (mediaType/1125459975 var2119!2) var2273)) ; Statement: r0.<org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException: java.lang.String mediaType> = r2 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1978845529=([org.apache.dubbo.remoting.http12.exception.HttpStatusException, int, java.lang.String], void), cast-from-var2711-to-var1653=([org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException], org.apache.dubbo.remoting.http12.exception.HttpStatusException), mediaType/1125459975=([org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException], java.lang.String)}
; {var2711=org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException, var2119=r0, var2273=r2, var1114=null_type, var2210=$r1, var1435=$r3, var2380=$r4, var3600=$r5, var2385=$r6, var1653=org.apache.dubbo.remoting.http12.exception.HttpStatusException, var3613=415}
; {org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException=var2711, r0=var2119, r2=var2273, null_type=var1114, $r1=var2210, $r3=var1435, $r4=var2380, $r5=var3600, $r6=var2385, org.apache.dubbo.remoting.http12.exception.HttpStatusException=var1653, 415=var3613}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException;	r2 := @parameter0: java.lang.String;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported Media Type \'");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.remoting.http12.exception.HttpStatusException: void <init>(int,java.lang.String)>(415, $r6);	r0.<org.apache.dubbo.remoting.http12.exception.UnsupportedMediaTypeException: java.lang.String mediaType> = r2;	return
;block_num 1