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

(declare-sort var3789 0)
(declare-sort var165 0)
(declare-sort var1565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1565_getServerSideCallbackServiceCacheKey/-2134169190 (var3789 String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3789 var3789)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3338 var3789) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3338 null-var3789)))
(declare-const var1145 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1145 null-String)))
(declare-const var44 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var44 null-Int)))
(define-const var2932 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2932)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2932!1 String)
(assert (= var2932!1 ""))
(define-const var2973 String (var1565_getServerSideCallbackServiceCacheKey/-2134169190 var3338 var1145 var44)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getServerSideCallbackServiceCacheKey(org.apache.dubbo.remoting.Channel,java.lang.String,int)>(r1, r2, i0) 
(assert true)
(define-const var3194 String (append/672562846 var2932!1 var2973)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2932!2 String)
(assert (= var2932!2 (str.++ var2932!1 var2973)))
(assert true)
(define-const var3431 String (append/672562846 var3194 ".invoker")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".invoker") 
(declare-const var3194!1 String)
(assert (= var3194!1 (str.++ var3194 ".invoker")))
(assert true)
(define-const var2073 String (toString/-2075883882 var3431)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1565_getServerSideCallbackServiceCacheKey/-2134169190=([org.apache.dubbo.remoting.Channel, java.lang.String, int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3789=org.apache.dubbo.remoting.Channel, var3338=r1, var1145=r2, var165=null_type, var44=i0, var2932=$r0, var1565=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var2973=$r3, var3194=$r4, var3431=$r5, var2073=$r6}
; {org.apache.dubbo.remoting.Channel=var3789, r1=var3338, r2=var1145, null_type=var165, i0=var44, $r0=var2932, org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var1565, $r3=var2973, $r4=var3194, $r5=var3431, $r6=var2073}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getServerSideCallbackServiceCacheKey(org.apache.dubbo.remoting.Channel,java.lang.String,int)>(r1, r2, i0);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".invoker");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1