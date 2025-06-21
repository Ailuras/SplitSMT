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

(declare-sort var2682 0)
(declare-sort var3923 0)
(declare-sort var2404 0)
(declare-sort var2755 0)
(declare-sort var2347 0)
(declare-sort var2611 0)
(declare-sort var549 0)
(declare-sort var2993 0)
(declare-sort var1590 0)
(declare-sort var1496 0)
(declare-sort var2357 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3923-init () var3923)
(declare-fun var2755_valueOf/-479746936 (Int) var2755)
(declare-fun getBytes/1068683673 (String) (Array Int Int))
(declare-fun var2611_wrappedBuffer/681999521 ((Array Int Int)) var2347)
(declare-fun <init>/1806608724 (var3923 var2404 var2755 var2347) void)
(declare-fun cast-from-var3923-to-var549 (var3923) var549)
(declare-fun var549_headers/1501691391 (var549) var2993)
(declare-fun cast-from-var1590-to-String (var1590) String)
(declare-fun set/410637369 (var2993 String var2357) var2993)
(declare-fun cast-from-String-to-var2357 (String) var2357)
(declare-fun var549_content/-506940573 (var549) var2347)
(declare-fun readableBytes/-922465106 (var2347) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2357 (Int) var2357)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var2404-HTTP_1_1 var2404)
(declare-const var1496-CONTENT_TYPE var1590)
(declare-const var1496-CONTENT_LENGTH var1590)
(declare-const var1143 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1143 null-Int)))
(declare-const var2119 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2119 null-String)))
(define-const var759 var3923 var3923-init) ; Statement: $r11 = new io.netty.handler.codec.http.DefaultFullHttpResponse 
(define-const var3525 var2404 var2404-HTTP_1_1) ; Statement: $r1 = <io.netty.handler.codec.http.HttpVersion: io.netty.handler.codec.http.HttpVersion HTTP_1_1> 
(define-const var3458 var2755 (var2755_valueOf/-479746936 var1143)) ; Statement: $r5 = staticinvoke <io.netty.handler.codec.http.HttpResponseStatus: io.netty.handler.codec.http.HttpResponseStatus valueOf(int)>(i0) 
(assert true)
(define-const var3622 (Array Int Int) (getBytes/1068683673 var2119)) ; Statement: $r3 = virtualinvoke r2.<java.lang.String: byte[] getBytes()>() 
(define-const var3838 var2347 (var2611_wrappedBuffer/681999521 var3622)) ; Statement: $r4 = staticinvoke <io.netty.buffer.Unpooled: io.netty.buffer.ByteBuf wrappedBuffer(byte[])>($r3) 
(assert true)
;(assert (<init>/1806608724 var759 var3525 var3458 var3838)) ; Statement: specialinvoke $r11.<io.netty.handler.codec.http.DefaultFullHttpResponse: void <init>(io.netty.handler.codec.http.HttpVersion,io.netty.handler.codec.http.HttpResponseStatus,io.netty.buffer.ByteBuf)>($r1, $r5, $r4) 

(declare-const var759!1 var3923)
(declare-const var3525!1 var2404)
(declare-const var3458!1 var2755)
(declare-const var3838!1 var2347)
(define-const var1491 var549 (cast-from-var3923-to-var549 var759!1)) ; Statement: $r12 = (io.netty.handler.codec.http.FullHttpResponse) $r11 
(define-const var1470 var2993 (var549_headers/1501691391 var1491)) ; Statement: r6 = interfaceinvoke $r12.<io.netty.handler.codec.http.FullHttpResponse: io.netty.handler.codec.http.HttpHeaders headers()>() 
(define-const var2280 var1590 var1496-CONTENT_TYPE) ; Statement: $r7 = <io.netty.handler.codec.http.HttpHeaderNames: io.netty.util.AsciiString CONTENT_TYPE> 
(define-const var3825 String (cast-from-var1590-to-String var2280)) ; Statement: $r13 = (java.lang.CharSequence) $r7 
(assert true)
;(assert (set/410637369 var1470 var3825 (cast-from-String-to-var2357 "text/plain"))) ; Statement: virtualinvoke r6.<io.netty.handler.codec.http.HttpHeaders: io.netty.handler.codec.http.HttpHeaders set(java.lang.CharSequence,java.lang.Object)>($r13, "text/plain") 

(declare-const var1470!1 var2993)
(declare-const var3825!1 String)
(declare-const var199 String)
(define-const var1297 var1590 var1496-CONTENT_LENGTH) ; Statement: $r8 = <io.netty.handler.codec.http.HttpHeaderNames: io.netty.util.AsciiString CONTENT_LENGTH> 
(define-const var3414 var549 (cast-from-var3923-to-var549 var759!1)) ; Statement: $r14 = (io.netty.handler.codec.http.FullHttpResponse) $r11 
(define-const var2449 var2347 (var549_content/-506940573 var3414)) ; Statement: $r9 = interfaceinvoke $r14.<io.netty.handler.codec.http.FullHttpResponse: io.netty.buffer.ByteBuf content()>() 
(assert true)
(define-const var3921 Int (readableBytes/-922465106 var2449)) ; Statement: $i1 = virtualinvoke $r9.<io.netty.buffer.ByteBuf: int readableBytes()>() 
(define-const var2595 Int (Int_valueOf/-1371140006 var3921)) ; Statement: $r10 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1) 
(define-const var3289 String (cast-from-var1590-to-String var1297)) ; Statement: $r15 = (java.lang.CharSequence) $r8 
(assert true)
;(assert (set/410637369 var1470!1 var3289 (cast-from-Int-to-var2357 var2595))) ; Statement: virtualinvoke r6.<io.netty.handler.codec.http.HttpHeaders: io.netty.handler.codec.http.HttpHeaders set(java.lang.CharSequence,java.lang.Object)>($r15, $r10) 

(declare-const var1470!2 var2993)
(declare-const var3289!1 String)
(declare-const var2595!1 Int)
(define-const var2527 var549 (cast-from-var3923-to-var549 var759!1)) ; Statement: $r16 = (io.netty.handler.codec.http.FullHttpResponse) $r11 
 ; Statement: return $r16 
(check-sat)
; {var3923-init=([], io.netty.handler.codec.http.DefaultFullHttpResponse), var2755_valueOf/-479746936=([int], io.netty.handler.codec.http.HttpResponseStatus), getBytes/1068683673=([java.lang.String], byte[]), var2611_wrappedBuffer/681999521=([byte[]], io.netty.buffer.ByteBuf), <init>/1806608724=([io.netty.handler.codec.http.DefaultFullHttpResponse, io.netty.handler.codec.http.HttpVersion, io.netty.handler.codec.http.HttpResponseStatus, io.netty.buffer.ByteBuf], void), cast-from-var3923-to-var549=([io.netty.handler.codec.http.DefaultFullHttpResponse], io.netty.handler.codec.http.FullHttpResponse), var549_headers/1501691391=([io.netty.handler.codec.http.FullHttpResponse], io.netty.handler.codec.http.HttpHeaders), cast-from-var1590-to-String=([io.netty.util.AsciiString], java.lang.CharSequence), set/410637369=([io.netty.handler.codec.http.HttpHeaders, java.lang.CharSequence, java.lang.Object], io.netty.handler.codec.http.HttpHeaders), cast-from-String-to-var2357=([java.lang.String], java.lang.Object), var549_content/-506940573=([io.netty.handler.codec.http.FullHttpResponse], io.netty.buffer.ByteBuf), readableBytes/-922465106=([io.netty.buffer.ByteBuf], int), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2357=([java.lang.Integer], java.lang.Object)}
; {var1143=i0, var2119=r2, var2682=null_type, var3923=io.netty.handler.codec.http.DefaultFullHttpResponse, var759=$r11, var2404=io.netty.handler.codec.http.HttpVersion, var3525=$r1, var2755=io.netty.handler.codec.http.HttpResponseStatus, var3458=$r5, var3622=$r3, var2347=io.netty.buffer.ByteBuf, var2611=io.netty.buffer.Unpooled, var3838=$r4, var549=io.netty.handler.codec.http.FullHttpResponse, var1491=$r12, var2993=io.netty.handler.codec.http.HttpHeaders, var1470=r6, var1590=io.netty.util.AsciiString, var1496=io.netty.handler.codec.http.HttpHeaderNames, var2280=$r7, var3825=$r13, var2357=java.lang.Object, var199="text/plain", var1297=$r8, var3414=$r14, var2449=$r9, var3921=$i1, var2595=$r10, var3289=$r15, var2527=$r16}
; {i0=var1143, r2=var2119, null_type=var2682, io.netty.handler.codec.http.DefaultFullHttpResponse=var3923, $r11=var759, io.netty.handler.codec.http.HttpVersion=var2404, $r1=var3525, io.netty.handler.codec.http.HttpResponseStatus=var2755, $r5=var3458, $r3=var3622, io.netty.buffer.ByteBuf=var2347, io.netty.buffer.Unpooled=var2611, $r4=var3838, io.netty.handler.codec.http.FullHttpResponse=var549, $r12=var1491, io.netty.handler.codec.http.HttpHeaders=var2993, r6=var1470, io.netty.util.AsciiString=var1590, io.netty.handler.codec.http.HttpHeaderNames=var1496, $r7=var2280, $r13=var3825, java.lang.Object=var2357, "text/plain"=var199, $r8=var1297, $r14=var3414, $r9=var2449, $i1=var3921, $r10=var2595, $r15=var3289, $r16=var2527}
;seq <java.lang.String: byte[] getBytes()>
;cnt {"<java.lang.String: byte[] getBytes()>": 1}
;stmts i0 := @parameter0: int;	r2 := @parameter1: java.lang.String;	$r11 = new io.netty.handler.codec.http.DefaultFullHttpResponse;	$r1 = <io.netty.handler.codec.http.HttpVersion: io.netty.handler.codec.http.HttpVersion HTTP_1_1>;	$r5 = staticinvoke <io.netty.handler.codec.http.HttpResponseStatus: io.netty.handler.codec.http.HttpResponseStatus valueOf(int)>(i0);	$r3 = virtualinvoke r2.<java.lang.String: byte[] getBytes()>();	$r4 = staticinvoke <io.netty.buffer.Unpooled: io.netty.buffer.ByteBuf wrappedBuffer(byte[])>($r3);	specialinvoke $r11.<io.netty.handler.codec.http.DefaultFullHttpResponse: void <init>(io.netty.handler.codec.http.HttpVersion,io.netty.handler.codec.http.HttpResponseStatus,io.netty.buffer.ByteBuf)>($r1, $r5, $r4);	$r12 = (io.netty.handler.codec.http.FullHttpResponse) $r11;	r6 = interfaceinvoke $r12.<io.netty.handler.codec.http.FullHttpResponse: io.netty.handler.codec.http.HttpHeaders headers()>();	$r7 = <io.netty.handler.codec.http.HttpHeaderNames: io.netty.util.AsciiString CONTENT_TYPE>;	$r13 = (java.lang.CharSequence) $r7;	virtualinvoke r6.<io.netty.handler.codec.http.HttpHeaders: io.netty.handler.codec.http.HttpHeaders set(java.lang.CharSequence,java.lang.Object)>($r13, "text/plain");	$r8 = <io.netty.handler.codec.http.HttpHeaderNames: io.netty.util.AsciiString CONTENT_LENGTH>;	$r14 = (io.netty.handler.codec.http.FullHttpResponse) $r11;	$r9 = interfaceinvoke $r14.<io.netty.handler.codec.http.FullHttpResponse: io.netty.buffer.ByteBuf content()>();	$i1 = virtualinvoke $r9.<io.netty.buffer.ByteBuf: int readableBytes()>();	$r10 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1);	$r15 = (java.lang.CharSequence) $r8;	virtualinvoke r6.<io.netty.handler.codec.http.HttpHeaders: io.netty.handler.codec.http.HttpHeaders set(java.lang.CharSequence,java.lang.Object)>($r15, $r10);	$r16 = (io.netty.handler.codec.http.FullHttpResponse) $r11;	return $r16
;block_num 1