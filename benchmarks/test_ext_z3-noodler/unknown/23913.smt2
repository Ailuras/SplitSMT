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

(declare-sort var2592 0)
(declare-sort var2287 0)
(declare-sort var2689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun headers/-748456545 (var2592) var2287)
(declare-fun append/-1031950772 (String var2689) String)
(declare-fun cast-from-var2287-to-var2689 (var2287) var2689)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2592 var2592)
(declare-const var3560 var2592) ; Statement: r1 := @this: org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter 
(assert (not (= var3560 null-var2592)))
(define-const var2909 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2909)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2909!1 String)
(assert (= var2909!1 ""))
(assert true)
(define-const var1684 String (append/672562846 var2909!1 "Http2HeadersAdapter{headers=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2HeadersAdapter{headers=") 
(declare-const var2909!2 String)
(assert (= var2909!2 (str.++ var2909!1 "Http2HeadersAdapter{headers=")))
(define-const var2237 var2287 (headers/-748456545 var3560)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter: io.netty.incubator.codec.http3.Http3Headers headers> 
(assert true)
(define-const var39 String (append/-1031950772 var1684 (cast-from-var2287-to-var2689 var2237))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1684!1 String)
(assert (str.prefixof var1684 var1684!1))
(assert true)
(define-const var3439 String (append/-1166366385 var39 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var39!1 String)
(assert (str.prefixof var39 var39!1))
(assert true)
(define-const var3030 String (toString/-2075883882 var3439)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), headers/-748456545=([org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter], io.netty.incubator.codec.http3.Http3Headers), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2287-to-var2689=([io.netty.incubator.codec.http3.Http3Headers], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2592=org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter, var3560=r1, var2909=$r0, var1684=$r3, var2287=io.netty.incubator.codec.http3.Http3Headers, var2237=$r2, var2689=java.lang.Object, var39=$r4, var3439=$r5, var3030=$r6}
; {org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter=var2592, r1=var3560, $r0=var2909, $r3=var1684, io.netty.incubator.codec.http3.Http3Headers=var2287, $r2=var2237, java.lang.Object=var2689, $r4=var39, $r5=var3439, $r6=var3030}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2HeadersAdapter{headers=");	$r2 = r1.<org.apache.dubbo.remoting.http3.netty4.Http2HeadersAdapter: io.netty.incubator.codec.http3.Http3Headers headers>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1