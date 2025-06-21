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

(declare-sort var21 0)
(declare-sort var3952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun fieldToString/193576045 (var3952) String)
(declare-fun cast-from-var21-to-var3952 (var21) var3952)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var21 var21)
(declare-const var102 var21) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter 
(assert (not (= var102 null-var21)))
(define-const var2303 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2303)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2303!1 String)
(assert (= var2303!1 ""))
(assert true)
(define-const var3273 String (append/672562846 var2303!1 "ServletHttpResponseAdapter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpResponseAdapter{") 
(declare-const var2303!2 String)
(assert (= var2303!2 (str.++ var2303!1 "ServletHttpResponseAdapter{")))
(assert true)
(define-const var730 String (fieldToString/193576045 (cast-from-var21-to-var3952 var102))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: java.lang.String fieldToString()>() 
(assert true)
(define-const var93 String (append/672562846 var3273 var730)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3273!1 String)
(assert (= var3273!1 (str.++ var3273 var730)))
(assert true)
(define-const var3416 String (append/-1166366385 var93 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var93!1 String)
(assert (str.prefixof var93 var93!1))
(assert true)
(define-const var3156 String (toString/-2075883882 var3416)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), fieldToString/193576045=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), cast-from-var21-to-var3952=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpResponse), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var21=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter, var102=r1, var2303=$r0, var3273=$r3, var3952=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var730=$r2, var93=$r4, var3416=$r5, var3156=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter=var21, r1=var102, $r0=var2303, $r3=var3273, org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var3952, $r2=var730, $r4=var93, $r5=var3416, $r6=var3156}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpResponseAdapter{");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpResponseAdapter: java.lang.String fieldToString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1